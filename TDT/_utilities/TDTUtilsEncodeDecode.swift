//
//  TDTUtilsEncodeDecode.swift
//  TDT
//
//  Created by Kevin on 8/27/16.
//  Copyright © 2016 R. Kevin Ryan. All rights reserved.
//

// adapted from:  https://gist.github.com/nubbel/5b0a5cb2bf6a2e353061

import Foundation

func encode<T>(inout value: T) -> NSData {
    return withUnsafePointer(&value) { p in
        NSData(bytes: p, length: sizeofValue(value))
    }
}

func decode<T>(data: NSData) -> T {
    let pointer = UnsafeMutablePointer<T>.alloc(sizeof(T.Type))
    data.getBytes(pointer, length: sizeof(T))
    return pointer.move()
}
