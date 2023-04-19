import Foundation

public protocol StorageProtocol {
    func set<T>(_ value: T?, forKey key: StorageKey) throws
    func get<T>(forKey key: StorageKey) throws -> T?
}

public extension StorageProtocol {

    func store<T>(_ value: T?, forKey key: StorageKey, usingEncoder encoder: JSONEncoder = .init()) throws where T: Encodable {
        let data = try encoder.encode(value)
        try set(data, forKey: key)
    }

    func retrieve<T>(forKey key: StorageKey, usingDecoder decoder: JSONDecoder = .init()) throws -> T? where T: Decodable {
        guard let data: Data = try get(forKey: key) else {
            return nil
        }
        return try decoder.decode(T.self, from: data) as T
    }
    
}
