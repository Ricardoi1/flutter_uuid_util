import Flutter
import UIKit

public class UuidUtilPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "uuid_util", binaryMessenger: registrar.messenger())
        let instance = UuidUtilPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "getUuid":
            result(PLWKeyChainManager.shared.getUuid())
        default:
            break
        }
    }
}

class PLWKeyChainManager {
    static let shared = PLWKeyChainManager()

    private var bundleId: String? {
        Bundle.main.infoDictionary?["CFBundleIdentifier"] as? String
    }

    private func saveUuid(uuid: String) {
        guard let id = bundleId else {
            print("获取UUID失败")
            return
        }
        let identifier = id + "uuid.dic"
        // 获取存储数据的条件
        let keyChainSaveMutableDictionary = createQuaryMutableDictionary(identifier: identifier)
        // 删除旧的存储数据
        SecItemDelete(keyChainSaveMutableDictionary)
        // 设置数据
        do {
            let dic = ["uuid": uuid]
            try keyChainSaveMutableDictionary.setValue(NSKeyedArchiver.archivedData(withRootObject: dic, requiringSecureCoding: true), forKey: kSecValueData as String)
        } catch {
            print("出错了:\(error)")
        }

        // 进行存储数据
        let saveState = SecItemAdd(keyChainSaveMutableDictionary, nil)
        print("储存成功了吗:\(saveState)")
    }

    public func getUuid() -> String {
        guard let id = bundleId else {
            print("获取UUID失败")
            return ""
        }
        let identifier = id + "uuid.dic"

        var idObject: NSDictionary?
        // 获取查询条件
        let keyChainReadmutableDictionary = createQuaryMutableDictionary(identifier: identifier)
        // 提供查询数据的两个必要参数
        keyChainReadmutableDictionary.setValue(kCFBooleanTrue, forKey: kSecReturnData as String)
        keyChainReadmutableDictionary.setValue(kSecMatchLimitOne, forKey: kSecMatchLimit as String)
        // 创建获取数据的引用
        var queryResult: AnyObject?
        // 通过查询是否存储在数据
        let readStatus = withUnsafeMutablePointer(to: &queryResult) { SecItemCopyMatching(keyChainReadmutableDictionary, UnsafeMutablePointer($0)) }
        if readStatus == errSecSuccess {
            if let data = queryResult as! NSData? {
                do {
                    idObject = try NSKeyedUnarchiver.unarchivedObject(ofClass: NSDictionary.self, from: data as Data)
                } catch {
                    print("出错了:\(error)")
                }
            }
        }
        if let res = idObject?["uuid"] as? String {
            // keychain有，如果卸载过UserDefaults就没有，更新UserDefaults中的uuid
            UserDefaults.standard.set(res, forKey: identifier)
            return res
        } else if let userRes = UserDefaults.standard.string(forKey: identifier) {
            // keychain没有但是userdefaults有，说明迁移了账号，更新keychain中的id
            saveUuid(uuid: userRes)
            return userRes
        } else {
            // 都没有，说明第一次下载
            let str = UUID().uuidString
            saveUuid(uuid: str)
            UserDefaults.standard.set(str, forKey: identifier)
            return str
        }
    }

    private func createQuaryMutableDictionary(identifier: String) -> NSMutableDictionary {
        // 创建一个条件字典
        let keychainQuaryMutableDictionary = NSMutableDictionary(capacity: 0)
        // 设置条件存储的类型
        keychainQuaryMutableDictionary.setValue(kSecClassGenericPassword, forKey: kSecClass as String)
        // 设置存储数据的标记
        keychainQuaryMutableDictionary.setValue(identifier, forKey: kSecAttrService as String)
        keychainQuaryMutableDictionary.setValue(identifier, forKey: kSecAttrAccount as String)
        // 设置数据访问属性
        keychainQuaryMutableDictionary.setValue(kSecAttrAccessibleAfterFirstUnlock, forKey: kSecAttrAccessible as String)
        // 返回创建条件字典
        return keychainQuaryMutableDictionary
    }
}
