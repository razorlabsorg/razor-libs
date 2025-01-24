#[test_only]
module razor_libs::fixedpoint96_test {
  use razor_libs::fixedpoint96;

  #[test]
  public fun test_resolution() {
    let res = fixedpoint96::resolution();
    assert!(res == 96, 0);
  }

  #[test]
  public fun test_q96() {
    let q96 = fixedpoint96::q96();
    assert!(q96 == 0x1000000000000000000000000, 0);
  }
}