use std::io;


struct Token {
    symbol: String,
    name: String,
    totalSupply: u64,
}

impl Token {
    fn new()-> Self {
       Token {
        symbol: String:: new(),
        name: String::new(),
        totalSupply:  1_500_000_000,
       }
    }

       fn set_symbol(&mut self, _symbol: String) {
           self.symbol = _symbol.clone();
           println!("TCD {}", _symbol);
       } 

       fn get_symbol(&self) -> &String {
        &self.symbol 

       }

       fn set_name(&mut self, name: String) {
        self.name = name;
       }

       fn mint_Token(&mut self) -> String {
         const MAX_SUPPLY: u64 = 1_500_000_000;
         let remaining_supply = MAX_SUPPLY - self.totalSupply;
         if remaining_supply > 0 {
            self.totalSupply += remaining_supply;
            return format!("tokens minted: {}", remaining_supply);
         } else {
           return String::new();
         }
       }

       fn get_name(&self) -> &String {
        &self.name
       }

       fn transfer(&mut self, _to: &mut Token, _value: u64) {
       if self.totalSupply >= _value {
        self.totalSupply -= _value;
        self.totalSupply += _value;
        println!("Transferred {} tokens from {} to {}", _value, self.name, _to.name);
       } else {
        println!("Insufficient balance for transfer");
    }

       }
    }

    fn main() {
        println!("Enter sender name:");
        let mut sender_name = String::new();
        io::stdin().read_line(&mut sender_name).expect("Failed to read line");
    
        println!("Enter recipient name:");
        let mut recipient_name = String::new();
        io::stdin().read_line(&mut recipient_name).expect("Failed to read line");
    
        let mut sender = Token::new();
        sender.set_name(sender_name.trim().to_string());
        sender.set_symbol("TCD".to_string());
    
        let mut recipient = Token::new();
        recipient.set_name(recipient_name.trim().to_string());
        recipient.set_symbol("TCD".to_string());
    
        println!("Enter amount to transfer:");
        let mut amount_str = String::new();
        io::stdin().read_line(&mut amount_str).expect("Failed to read line");
        let amount: u64 = amount_str.trim().parse().expect("Please enter a valid number");
    
        sender.transfer(&mut recipient, amount);
    }
