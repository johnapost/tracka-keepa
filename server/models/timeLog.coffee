db = require '../db'

schema = db.Schema {
  _user:
    type: db.Schema.Types.ObjectId
    ref: 'User'
    required: true
  startTime:
    type: Date
    required: false
  stopTime:
    type: Date
    required: false
}

module.exports = db.model 'TimeLog', schema
