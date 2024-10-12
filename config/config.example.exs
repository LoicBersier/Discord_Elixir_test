import Config

config :nostrum,
  token: "bot token goes here",
  gateway_intents: [
    :guilds,
    :guild_members,
    :guild_messages,
    :message_content,
    :guild_message_reactions
  ]
