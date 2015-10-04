db = require '../db'

schema = db.Schema {
  _user:
    type: db.Schema.Types.ObjectId
    ref: 'User'
    required: true
  body:
    type: String
    required: true
  date:
    type: Date
    required: true
    default: Date.now
}

module.exports = db.model 'Post', schema
