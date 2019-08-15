import * as Yup from 'yup'
import { startOfHour, parseISO, isBefore, format, subHours } from 'date-fns'

import Appointment from '../models/Appointment'
import User from '../models/User'
import File from '../models/File'

import Notification from '../schemas/Notification'

class AppointmentController {
  async index(req, res) {
    const { page = 1 } = req.query
    const limit = 20

    const appointment = await Appointment.findAll({
      where: { user_id: req.userId, canceled_at: null },
      order: ['date'],
      attributes: ['id', 'date'],
      limit,
      offset: (page - 1) * limit,
      include: [
        {
          model: User,
          as: 'provider',
          attributes: ['id', 'name'],
          include: [
            {
              model: File,
              as: 'avatar',
              attributes: ['id', 'path', 'url'],
            },
          ],
        },
      ],
    })

    return res.json(appointment)
  }

  async store(req, res) {
    const schema = Yup.object().shape({
      provider_id: Yup.number().required(),
      date: Yup.date().required(),
    })

    if (!(await schema.isValid(req.body))) {
      return res.status(400).json({ error: 'Validation fails!' })
    }

    const { provider_id, date } = req.body

    const isProvider = await User.findOne({
      where: { id: provider_id, provider: true },
    })

    if (!isProvider) {
      return res
        .status(401)
        .json({ error: 'You can only create appointments with providers!' })
    }

    if (provider_id === req.userId) {
      return res
        .status(401)
        .json({ error: 'You can not create appointments to yourself!' })
    }

    const hourStart = startOfHour(parseISO(date))

    if (isBefore(hourStart, new Date())) {
      return res.status(400).json({ error: 'Past dates are not allowed!' })
    }

    const checkAvailability = await Appointment.findOne({
      where: {
        provider_id,
        canceled_at: null,
        date: hourStart,
      },
    })

    if (checkAvailability) {
      return res
        .status(400)
        .json({ error: 'Appointment date is not available!' })
    }

    const appointment = await Appointment.create({
      user_id: req.userId,
      provider_id,
      date,
    })

    const user = await User.findByPk(req.userId)
    const formatedDate = format(hourStart, "MMMM dd 'at' hh:mm a")

    await Notification.create({
      content: `New appointment from ${user.name} on ${formatedDate}`,
      user: provider_id,
    })
    return res.json(appointment)
  }

  async delete(req, res) {
    const appointment = await Appointment.findByPk(req.params.id)

    if (appointment.user_id !== req.userId) {
      return res.status(401).json({
        error: "You don't have permissions to cancel this appointment!",
      })
    }

    const dateSubHours = subHours(appointment.date, 2)

    if (isBefore(dateSubHours, new Date())) {
      return res.status(401).json({
        error: 'You can only cancel appointments 2 hours in advance!',
      })
    }

    appointment.canceled_at = new Date()

    await appointment.save()

    return res.json(appointment)
  }
}

export default new AppointmentController()
