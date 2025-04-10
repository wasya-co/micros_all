
  def test

    match = { '$match': {
      'tag_ids': {
        '$in': [
          BSON::ObjectId('658db0d00f5b4f4471bdb3b6'), # inbox
        ],
      }
    } }

    # tags = { '$lookup': {
    #   'from':         'wco_tags',
    #   'localField':   '_id',
    #   'foreignField': 'conversation_id',
    #   'pipeline': [
    #     { '$match': { 'read_at': nil } },
    #     { '$sort': { 'created_at': 1 } },
    #     { '$project': { 'subject': 1, 'created_at': 1 } },
    #   ],
    #   'as':           'unread_messages',
    # } }

    unread_messages = { '$lookup': {
      'from':         'wco_email_message',
      'localField':   '_id',
      'foreignField': 'conversation_id',
      'pipeline': [
        { '$match': { 'read_at': nil } },
        { '$sort': { 'created_at': 1 } },
        { '$project': { 'subject': 1, 'created_at': 1 } },
      ],
      'as':           'unread_messages',
    } }

    last_message = { '$lookup': {
      'from':         'wco_email_message',
      'localField':   '_id',
      'foreignField': 'conversation_id',
      'pipeline': [
        { '$sort': { 'created_at': -1 } },
        { '$limit': 1 },
        { '$project': { 'subject': 1, 'created_at': 1 } },
      ],
      'as':           'last_message',
    } }
    project = { '$project': {
      "subject": 1,
      "all_messages": { '$concatArrays': [ '$unread_messages', '$last_message' ] },
    } }

    outs = WcoEmail::Conversation.collection.aggregate([
      match,
      unread_messages,
      last_message,
      project,
    ]).to_a


  end

