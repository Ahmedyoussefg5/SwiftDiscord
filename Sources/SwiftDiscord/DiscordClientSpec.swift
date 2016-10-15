import Foundation

public protocol DiscordClientSpec : class, DiscordEngineClient {
	var connected: Bool { get }
	var guilds: [String: DiscordGuild] { get }
	var isBot: Bool { get }
	var relationships: [[String: Any]] { get } // TODO make this a [DiscordRelationship]
	var token: String { get }
	var user: DiscordUser? { get }
	var voiceState: DiscordVoiceState? { get }

	init(token: String)

	func connect()
	func disconnect()
	func on(_ event: String, callback: @escaping ([Any]) -> Void)
	func handleEvent(_ event: String, with data: [Any])
	func joinVoiceChannel(_ channelId: String, callback: @escaping (String) -> Void)
	func leaveVoiceChannel(_ channelId: String)

	// REST API
	func bulkDeleteMessages(_ messages: [String], on channelId: String)
	func createInvite(for channelId: String, options: [DiscordEndpointOptions.CreateInvite],
		callback: @escaping (Any) -> Void)
	func deleteChannel(_ channelId: String)
	func deleteChannelPermission(_ overwriteId: String, on channelId: String)
	func deleteMessage(_ messageId: String, on channelId: String)
	func deletePinnedMessage(_ messageId: String, on channelId: String)
	func editMessage(_ messageId: String, on channelId: String, content: String)
	func editChannelPermission(_ permissionOverwrite: DiscordPermissionOverwrite, on channelId: String)
	func getBotURL(with permissions: [DiscordPermission]) -> URL?
	func getChannel(_ channelId: String, callback: @escaping (DiscordGuildChannel?) -> Void)
	func getInvites(for channelId: String, callback: @escaping (Any) -> Void)
	func getMessages(for channel: String, options: [DiscordEndpointOptions.GetMessage],
		callback: @escaping ([DiscordMessage]) -> Void)
	func getPinnedMessages(for channelId: String, callback: @escaping ([DiscordMessage]) -> Void)
	func sendMessage(_ message: String, to channelId: String, tts: Bool)
	func triggerTyping(on channelId: String)
}
