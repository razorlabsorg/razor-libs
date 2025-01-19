/// @title Base64 
/// @notice A library for encoding and decoding base64 strings
module razor_libs::base64 {
  use std::vector;

  const ERR_INVALID_LENGTH: u64 = 0;
  const ERR_INVALID_CHARACTER: u64 = 1;

  const BASE16_CHARS: vector<u8> = b"0123456789abcdef";
  const BASE64_CHARS: vector<u8> = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
  const PADDING: u8 = 0x3d;
  const DECODE_LUT: vector<u8> = x"00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000003f00010203040506070809000000000000000a0b0c0d0e0f00000000000000000000000000000000000000000000000000000a0b0c0d0e0f00000000000000000000000000000000000000000000000000";

  const DECODE_LUT_64: vector<u8> = x"000000000000000000000000000000000000000000000000000000000000000000000000000000000000003e0000003f3435363738393a3b3c3d00000000000000000102030405060708090a0b0c0d0e0f101112131415161718190000000000001a1b1c1d1e1f202122232425262728292a2b2c2d2e2f303132330000000000";

  const ECODE_LUT: vector<u8> = vector<u8>[
    255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255,
    255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255,
    255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 0, 1, 2,  3, 4, 5,
    6, 7,  8, 9, 255, 255, 255, 255, 255, 255, 255, 10, 11, 12, 13, 14, 15, 255,
    255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255,
    255, 255, 255, 255, 255, 255, 255, 10, 11, 12, 13, 14, 15, 255, 255, 255, 255, 255,
    255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255,
    255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255,
    255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255,
    255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255,
    255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255,
    255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255,
    255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255,
    255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255,
    255, 255, 255, 255
  ];

  const ECODE_LUT_64: vector<u8> = vector<u8>[
    255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255,
    255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255,
    255, 255, 255, 255, 255, 255, 255, 62/*43*/, 255, 255, 255, 63/*47*/, 52/*48*/, 53, 54, 55, 56, 57,
    58, 59,  60, 61/*57*/, 255, 255, 255, 255, 255, 255, 255, 0/*65*/, 1, 2, 3, 4, 5, 6,
    7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24,
    25/*90*/, 255, 255, 255, 255, 255, 255, 26/*97*/, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36,
    37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51/*122*/, 255, 255, 255,
    255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255,
    255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255,
    255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255,
    255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255,
    255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255,
    255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255,
    255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255,
    255, 255, 255, 255
  ];

  public fun encode(bytes: vector<u8>): vector<u8> {
    let retval = vector::empty<u8>();
    let n = vector::length(&bytes);
    let i = 0u64;
    while (i < n) {
      let v = vector::borrow(&bytes, i);
      let c1 = vector::borrow(&BASE16_CHARS, ((*v >> 4) as u64));
      let c2 = vector::borrow(&BASE16_CHARS, ((*v & 0x0f) as u64));
      vector::push_back(&mut retval, *c1);
      vector::push_back(&mut retval, *c2);
      i = i + 1;
    };

    return retval
  }

  public fun decode(bytes: vector<u8>): vector<u8> {
    let retval = vector::empty<u8>();
    let n = vector::length(&bytes);
    assert!(n & 1 == 0, ERR_INVALID_LENGTH);
    let i = 0u64;
    while (i < n) {
      let s0 = vector::borrow(&bytes, i);
      let s1 = vector::borrow(&bytes, i + 1);
      let r0 = vector::borrow(&DECODE_LUT, ((*s0) as u64));
      let r1 = vector::borrow(&DECODE_LUT, ((*s1) as u64));
      assert!((*r0 | *r1) < 128u8, ERR_INVALID_CHARACTER);
      let v = (((*r0 << 4) | *r1) as u8);
      vector::push_back(&mut retval, v);
      i = i + 2;
    };
    
    return retval
  }

  public fun encode_64(bytes: vector<u8>): vector<u8>{
    if (vector::length(&bytes) == 0){
      return b""
    };

    let retval = vector::empty<u8>();
    let n = vector::length(&bytes);
    let i = 0u64;

    while(i + 3 <= n){
      let v1 = vector::borrow(&bytes, i);
      let v2 = vector::borrow(&bytes, i+1);
      let v3 = vector::borrow(&bytes, i+2);
      let c1 = vector::borrow(&BASE64_CHARS, ((*v1 >> 2) as u64));
      let c2 = vector::borrow(&BASE64_CHARS, ((((*v1 & 0x03) << 4) | (*v2 >> 4)) as u64));
      let c3 = vector::borrow(&BASE64_CHARS, ((((*v2 & 0x0f) << 2) | ((*v3 & 0xc0) >> 6 )) as u64));
      let c4 = vector::borrow(&BASE64_CHARS, ((*v3 & 0x3f) as u64));
      vector::push_back(&mut retval, *c1);
      vector::push_back(&mut retval, *c2);
      vector::push_back(&mut retval, *c3);
      vector::push_back(&mut retval, *c4);
      i = i + 3;
    };

    let mod = n % 3;
    if (mod == 1){ // when 1 item is remained
      let v1 = vector::borrow(&bytes, i);
      let c1 = vector::borrow(&BASE64_CHARS, ((*v1 >> 2) as u64));
      let c2 = vector::borrow(&BASE64_CHARS, (((*v1 & 0x03) << 4 ) as u64));
      vector::push_back(&mut retval, *c1);
      vector::push_back(&mut retval, *c2);
      vector::push_back(&mut retval, PADDING);
      vector::push_back(&mut retval, PADDING);
    } else if(mod == 2){ // when 2 items are remained
      let v1 = vector::borrow(&bytes, i);
      let v2 = vector::borrow(&bytes, i + 1);
      let c1 = vector::borrow(&BASE64_CHARS, ((*v1 >> 2) as u64));
      let c2 = vector::borrow(&BASE64_CHARS, ((((*v1 & 0x03) << 4) | (*v2 >> 4)) as u64));
      let c3 = vector::borrow(&BASE64_CHARS, (((*v2 & 0x0f) << 2 ) as u64));
      vector::push_back(&mut retval, *c1);
      vector::push_back(&mut retval, *c2);
      vector::push_back(&mut retval, *c3);
      vector::push_back(&mut retval, PADDING);
    };

    return retval
  }

  public fun decode_64(bytes: vector<u8>): vector<u8>{
    if (vector::length(&bytes) == 0){
      return b""
    };

    let retval = vector::empty<u8>();
    let n = vector::length(&bytes);
    assert!(n % 4 == 0, ERR_INVALID_LENGTH);

    if(vector::borrow(&bytes, n - 1) == &PADDING){
      n = n - 1;
      if(vector::borrow(&bytes, n - 1) == &PADDING){
        n = n - 1;
      }
    };

    let i = 0u64;
    while(i + 4 <= n){
      let s1 = vector::borrow(&bytes, i);
      let s2 = vector::borrow(&bytes, i + 1);
      let s3 = vector::borrow(&bytes, i + 2);
      let s4 = vector::borrow(&bytes, i + 3);
      let r1 = vector::borrow(&DECODE_LUT_64, (*s1 as u64));
      let r2 = vector::borrow(&DECODE_LUT_64, (*s2 as u64));
      let r3 = vector::borrow(&DECODE_LUT_64, (*s3 as u64));
      let r4 = vector::borrow(&DECODE_LUT_64, (*s4 as u64));
      let v1 = (((*r1 << 2) | ((*r2 >> 4))) as u8);
      let v2 = ((*r2 << 4) | (*r3 >> 2) as u8);
      let v3 = (((*r3 << 6) | *r4) as u8);
      vector::push_back(&mut retval, v1);
      vector::push_back(&mut retval, v2);
      vector::push_back(&mut retval, v3);

      i = i + 4;
    };
    
    let mod = n - i ;
    assert!(mod != 1, ERR_INVALID_LENGTH);
    if(mod == 3){//when decoded bytes are composed of 2 items
      let s1 = vector::borrow(&bytes, i);
      let s2 = vector::borrow(&bytes, i + 1 );
      let s3 = vector::borrow(&bytes, i + 2 );
      let r1 = vector::borrow(&DECODE_LUT_64, (*s1 as u64));
      let r2 = vector::borrow(&DECODE_LUT_64, (*s2 as u64));
      let r3 = vector::borrow(&DECODE_LUT_64, (*s3 as u64));
      let v1 = ( ((*r1 << 2) | (*r2 >> 4) )  as u8);
      let v2 = (((*r2 << 4) | (*r3 >> 2)) as u8);
      vector::push_back(&mut retval, v1);
      vector::push_back(&mut retval, v2);
    } else if (mod == 2){//when decoded bytes are composed of single items
      let s1 = vector::borrow(&bytes, i);
      let s2 = vector::borrow(&bytes, i + 1);
      let r1 = vector::borrow(&DECODE_LUT_64, (*s1 as u64));
      let r2 = vector::borrow(&DECODE_LUT_64, (*s2 as u64));
      let v1 = (((*r1 << 2) | (*r2 >> 4))  as u8);
      vector::push_back(&mut retval, v1);
    };

    return retval
  }
}