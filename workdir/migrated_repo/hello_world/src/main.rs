fn main() {
    println!("Hello, World!");
}

#[cfg(test)]
mod tests {
    #[test]
    fn test_hello() {
        assert_eq!(2 + 2, 4);
    }

    #[test]
    fn test_greeting() {
        let msg = "Hello, World!";
        assert!(msg.contains("Hello"));
    }
}