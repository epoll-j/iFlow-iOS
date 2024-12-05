//
//  CertUtils.swift
//  iFlow
//
//  Created by Dubhe on 2023/8/20.
//

import Foundation
import NIO
import CNIOBoringSSL
import NIOSSL

let cert = [UInt8]("""
-----BEGIN CERTIFICATE-----
MIID5zCCAs+gAwIBAgIUNaaehw51u9TVoxtQ3LaMop8QVTowDQYJKoZIhvcNAQEL
BQAwgZQxCzAJBgNVBAYTAlpIMRIwEAYDVQQIDAlHdWFuZ0RvbmcxEjAQBgNVBAcM
CUd1YW5nWmhvdTEOMAwGA1UECgwFaUZsb3cxEzARBgNVBAsMCmlmbG93Lm1vYmkx
FjAUBgNVBAMMDWlGbG93IE1vYmkgQ0ExIDAeBgkqhkiG9w0BCQEWEWVwb2xsQGZv
eG1haWwuY29tMB4XDTIzMTIzMTExMzgwNloXDTI0MTIzMDExMzgwNlowgZQxCzAJ
BgNVBAYTAlpIMRIwEAYDVQQIDAlHdWFuZ0RvbmcxEjAQBgNVBAcMCUd1YW5nWmhv
dTEOMAwGA1UECgwFaUZsb3cxEzARBgNVBAsMCmlmbG93Lm1vYmkxFjAUBgNVBAMM
DWlGbG93IE1vYmkgQ0ExIDAeBgkqhkiG9w0BCQEWEWVwb2xsQGZveG1haWwuY29t
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAp4db7R5Sw3hVWjRROYb6
D/oOw6NfDgUq7P0EXOvb/KkD7YK2LrdbJyFPyzZNtdLOu1bPGdNWBFLnaQcM9f4o
4ystU0wfhr+0pXnIMczy2Y7osxvyp8SNvlHdKLfhhzto2XRpZMhy+Q1u0WXAad2O
s8G7d2RuqORXcoWrR/aAAsBfXP9W4ncHMcLd9LGsewVnWPRsfiWd573LRqyRHUsH
Fo83IZNhzCB12TB+y3Ij/VSS6k1CxR8rYgCXDMXE7ZtGe65r8cJX1H0czIYbNBz5
Rd62SfQfwFO35gWCg7Z1bMwY0H0gskMsCAAxnooWKKItAr4Vpr8ZyMeTJ1eUvyit
HwIDAQABoy8wLTAMBgNVHRMEBTADAQH/MB0GA1UdDgQWBBQLb4JZn0cX/gCmhmXS
tP85wlXHvjANBgkqhkiG9w0BAQsFAAOCAQEASYC52oK/genIXORJO+dhCUScCwbi
pT0FlZtI+2mMrJjxsRzaIVv97GymoXrucRahjP/7UoEGtvJ9WgwTXynH7uyx1EFJ
efNDib+m9oSeRYQuwT99lj7YGMsrv9fgIk7aCG942K9Bf51PzHIN3scJKQT7ePn4
5Flr5sz/OuW5W/aapGgxhY8aCfvwWXIxs0S6S0u2OXRyPnmzjdSmoylxwrLswRVK
+lCuc3mszp/Plez7wwcTCzyF6dcbCYa5Cp9xZ6bbhw0Q+7M5X0mJxXpkrxuF6fRp
hgGBPUqG5NlMe68c69lok639t/kPedMlDRXJHDxk+CyEVSP/h3/x+luHtQ==
-----END CERTIFICATE-----
""".utf8)

let privateKey = [UInt8]("""
-----BEGIN RSA PRIVATE KEY-----
MIIEowIBAAKCAQEAp4db7R5Sw3hVWjRROYb6D/oOw6NfDgUq7P0EXOvb/KkD7YK2
LrdbJyFPyzZNtdLOu1bPGdNWBFLnaQcM9f4o4ystU0wfhr+0pXnIMczy2Y7osxvy
p8SNvlHdKLfhhzto2XRpZMhy+Q1u0WXAad2Os8G7d2RuqORXcoWrR/aAAsBfXP9W
4ncHMcLd9LGsewVnWPRsfiWd573LRqyRHUsHFo83IZNhzCB12TB+y3Ij/VSS6k1C
xR8rYgCXDMXE7ZtGe65r8cJX1H0czIYbNBz5Rd62SfQfwFO35gWCg7Z1bMwY0H0g
skMsCAAxnooWKKItAr4Vpr8ZyMeTJ1eUvyitHwIDAQABAoIBABzINSNuZ8K8fFGE
loXfKjwvdnTnLxAOFDtmFudOAFwOv6WBJQKursLwxrA/kqdP4gOunOMve2I/yhEx
zGjA805gHyfl9q6kZgld/GaN8xUsp88J2K05KC8QCoKR4PXmX5Oom+jcRWCDjcv9
AstNbNR2Ttpqz1ZF8L40t+IjuAeAtRXC+dnAkL+TPD9yRuOJLjdG6gbFnaXMJ4ZZ
SVXe7lzGwJUDtG6OgrJkRf87YMQ0JKEUqw1nyITEoANyFnlAuoqfyf2AZOhkj+fr
K8ZagfpntV8+YFmta8reexAkE91XkGRilOdLNg3GDvNCrIzKKpu3fzDQXqTnnSdj
m0imwNkCgYEA4aCgc629lD+uPGo52SvSIeVBKJJZ6gAv9OqtQYZ4nJqAIsxNBd/g
puMGtWNa67GsOh56is2cpfAxwVMQIxVXnpUWX240BL6LjiFV7eLpwQ8KpU0bS5on
Lf9chsZWenh5ET11pZLJKG9cEyBC9ThwGVZCleZOyCdpUoyOfgH7BpcCgYEAvhSW
GaeCxJ9vLr2rdqPnKr/DA8Qm0g4NG660gQxrcAzgIc9IcM/F9WNjrRDMHEJ/NY+l
A/kJc6+xa0LF+FlPrTxb/Pp1VuBMPu7IGNHevDB4Jfl0IJN+3iHzRqRT34CHmiJQ
eC5yJpZ9bZjgZhSRoPLiFmshbLbnrlGgF1u9prkCgYEAjeuiYYEMeV6g8yGCJ6dX
srhohuOfqP/bKnwe5NN3tFG+faTyYdqTjYXJ53iKbSzB/4DCZeK1QO9X7JmZ0eeP
yJFQlFBWahGM6KbxTQPpMuWKNbXNkH1zXYx9n8zMApca2AxHnxE4dLWvPdySIXsR
j+5hTbajIWUg66q7ymjmhBsCgYBviHbW0NLLet3raEHPGLeQ/vp4IEXDJZmNb8Lc
oiP8mKF/VTilcVUv+sTHDT8nKeGo1QO3xA5GwoXxcTnm0skM1okHdRMbCfvTRZtF
7QesFyi455m7b7CWuQcdoVjRoYJv78iV7HLwr4cjovuxCkq1TS9ahjwTpXNmduDg
M+WhiQKBgAm/wWm7J8ELH6DVVsKjV3Ikiyz9dYb8quUS0VlZTMyF773Lykt+FleB
MOj5+qZ0rvtG1XKty7QyfGYQLMBvTuPgc+MQM7rEHB6Y2dQSbzLqS5cXRHo9Xe4u
ZCcOcJQpwDhqIdcBXx55W0LQmXnu0E1NR2fzHzLUo9yW0lsJqdBH
-----END RSA PRIVATE KEY-----
""".utf8)

public class CertUtils: NSObject {
    
    private static let certificate: NIOSSLCertificate = try! NIOSSLCertificate(bytes: cert, format: .pem)
    public static var certPool = NSMutableDictionary()
    
    public static func generateSelfSignedCert(host: String) -> NIOSSLCertificate {
        let pkey = getPrivateKeyPointer(bytes: privateKey)
        let x: OpaquePointer = CNIOBoringSSL_X509_new()!
        CNIOBoringSSL_X509_set_version(x, 2)
        let subject = CNIOBoringSSL_X509_NAME_new()
        CNIOBoringSSL_X509_NAME_add_entry_by_txt(subject, "C", MBSTRING_ASC, "SE", -1, -1, 0);
        CNIOBoringSSL_X509_NAME_add_entry_by_txt(subject, "ST", MBSTRING_ASC, "", -1, -1, 0);
        CNIOBoringSSL_X509_NAME_add_entry_by_txt(subject, "L", MBSTRING_ASC, "", -1, -1, 0);
        CNIOBoringSSL_X509_NAME_add_entry_by_txt(subject, "O", MBSTRING_ASC, "Tomduck", -1, -1, 0);
        CNIOBoringSSL_X509_NAME_add_entry_by_txt(subject, "OU", MBSTRING_ASC, "", -1, -1, 0);
        CNIOBoringSSL_X509_NAME_add_entry_by_txt(subject, "CN", MBSTRING_ASC, host, -1, -1, 0);
        
        var serial = randomSerialNumber()
        CNIOBoringSSL_X509_set_serialNumber(x, &serial)
        
        let notBefore = CNIOBoringSSL_ASN1_TIME_new()!
        var now = time(nil)
        CNIOBoringSSL_ASN1_TIME_set(notBefore, now)
        CNIOBoringSSL_X509_set_notBefore(x, notBefore)
        CNIOBoringSSL_ASN1_TIME_free(notBefore)
        
        now += 60 * 60 * 60  // Give ourselves an hour
        let notAfter = CNIOBoringSSL_ASN1_TIME_new()!
        CNIOBoringSSL_ASN1_TIME_set(notAfter, now)
        CNIOBoringSSL_X509_set_notAfter(x, notAfter)
        CNIOBoringSSL_ASN1_TIME_free(notAfter)
        
        CNIOBoringSSL_X509_set_pubkey(x, pkey)
        
        //        CNIOBoringSSL_PEM_read_bio_X509(cert, nil, nil, nil)
        
        CNIOBoringSSL_X509_set_issuer_name(x, CNIOBoringSSL_X509_get_subject_name(_ref()!))
        CNIOBoringSSL_X509_set_subject_name(x, subject)
        CNIOBoringSSL_X509_NAME_free(subject)
        addExtension(x509: x, nid: NID_basic_constraints, value: "critical,CA:FALSE")
        addExtension(x509: x, nid: NID_subject_key_identifier, value: "hash")
        addExtension(x509: x, nid: NID_subject_alt_name, value: "DNS:\(host)")
        addExtension(x509: x, nid: NID_ext_key_usage, value: "serverAuth,OCSPSigning")
        
        CNIOBoringSSL_X509_sign(x, pkey, CNIOBoringSSL_EVP_sha256())
        
        // 将证书转换为 DER 格式的字节数组
        var derBytesPointer: UnsafeMutablePointer<UInt8>? = nil
        let derLength = CNIOBoringSSL_i2d_X509(x, &derBytesPointer)
        
        // 确保内存安全，创建 Data 对象，并释放分配的内存
        let certData = Data(bytes: derBytesPointer!, count: Int(derLength))
        CNIOBoringSSL_OPENSSL_free(derBytesPointer)
        
        let cert = try! NIOSSLCertificate(bytes: Array(certData), format: .der)
        CNIOBoringSSL_X509_free(x)
        
        return cert
    }
    
    private static func _ref() -> OpaquePointer? {
        let ref = cert.withUnsafeBytes { (ptr) -> OpaquePointer? in
            let bio = CNIOBoringSSL_BIO_new_mem_buf(ptr.baseAddress, ptr.count)!
            
            defer {
                CNIOBoringSSL_BIO_free(bio)
            }
            
            return CNIOBoringSSL_PEM_read_bio_X509(bio, nil, nil, nil)
        }
        return ref
    }
    
    private static func randomSerialNumber() -> ASN1_INTEGER {
        let bytesToRead = 20
        let fd = open("/dev/urandom", O_RDONLY)
        precondition(fd != -1)
        defer {
            close(fd)
        }
        
        var readBytes = Array.init(repeating: UInt8(0), count: bytesToRead)
        let readCount = readBytes.withUnsafeMutableBytes {
            return read(fd, $0.baseAddress, bytesToRead)
        }
        precondition(readCount == bytesToRead)
        
        // Our 20-byte number needs to be converted into an integer. This is
        // too big for Swift's numbers, but BoringSSL can handle it fine.
        let bn = CNIOBoringSSL_BN_new()
        defer {
            CNIOBoringSSL_BN_free(bn)
        }
        
        _ = readBytes.withUnsafeBufferPointer {
            CNIOBoringSSL_BN_bin2bn($0.baseAddress, $0.count, bn)
        }
        
        // We want to bitshift this right by 1 bit to ensure it's smaller than
        // 2^159.
        CNIOBoringSSL_BN_rshift1(bn, bn)
        
        // Now we can turn this into our ASN1_INTEGER.
        var asn1int = ASN1_INTEGER()
        CNIOBoringSSL_BN_to_ASN1_INTEGER(bn, &asn1int)
        
        return asn1int
    }
    
    private static func getPrivateKeyPointer(bytes: [UInt8]) -> OpaquePointer {
        let ref = bytes.withUnsafeBytes { (ptr) -> OpaquePointer? in
            let bio = CNIOBoringSSL_BIO_new_mem_buf(ptr.baseAddress!, ptr.count)!
            defer {
                CNIOBoringSSL_BIO_free(bio)
            }
            
            return CNIOBoringSSL_PEM_read_bio_PrivateKey(bio, nil, nil, nil)
        }
        
        return ref!
    }
    
    private static func addExtension(x509: OpaquePointer, nid: CInt, value: String) {
        var extensionContext = X509V3_CTX()
        
        CNIOBoringSSL_X509V3_set_ctx(&extensionContext, x509, x509, nil, nil, 0)
        let ext = value.withCString { (pointer) in
            return CNIOBoringSSL_X509V3_EXT_nconf_nid(nil, &extensionContext, nid, UnsafeMutablePointer(mutating: pointer))
        }!
        CNIOBoringSSL_X509_add_ext(x509, ext, -1)
        CNIOBoringSSL_X509_EXTENSION_free(ext)
    }
}
