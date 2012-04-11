Players = new Meteor.Collection "players"

if Meteor.is_client
        Template.leaderboard.players = ->
                Players.find {}, sort: {score: -1,name: 1}

        Template.leaderboard.selected_name = ->
                Players.findOne(Session.get("selected_player"))?.name

        Template.player.selected = ->
                if Session.equals("selected_player", this._id) then "selected" else ''

        Template.leaderboard.events =
                "click input.inc": ->
                        Players.update(Session.get("selected_player"), $inc: score: 5)
        Template.player.events =
                click: -> Session.set("selected_player",this._id)

if Meteor.is_server
        Meteor.startup ->
                if Players.find().count() == 0
                        names = [ "Ada Lovelace",
                                "Grace Hopper",
                                "Marie Curie",
                                "Carl Friedrich Gauss",
                                "Nikola Tesla",
                                "Claude Shannon"
                                ]
                        for name in names
                                Players.insert(name: name, score: Math.floor(Math.random()*10)*5)
