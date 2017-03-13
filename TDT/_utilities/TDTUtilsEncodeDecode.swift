//
//  TDTUtilsEncodeDecode.swift
//  TDT
//
//  Created by Kevin on 8/27/16.
//  Copyright © 2016 R. Kevin Ryan. All rights reserved.
//

// adapted from:  https://gist.github.com/nubbel/5b0a5cb2bf6a2e353061

import Foundation

func encode<T>(value: inout T) -> NSData {
    return withUnsafePointer(to: &value) { p in
        NSData(bytes: p, length: MemoryLayout.size(ofValue: value))
    }
}

func decode<T>(_ data: Data) -> T {
    let pointer = UnsafeMutablePointer<T>.allocate(capacity: MemoryLayout<T.Type>.size)
    (data as NSData).getBytes(pointer, length: MemoryLayout<T>.size)
    return pointer.move()
}
