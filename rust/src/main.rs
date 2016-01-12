use std::io::prelude::*;
use std::io;

extern crate advent_of_code;
use advent_of_code::*;

fn main() {
    let mut input = String::new();
    io::stdin().read_to_string(&mut input).ok();
    let day = Day06::new(input);
    println!("{}", day.solve().unwrap());
}
