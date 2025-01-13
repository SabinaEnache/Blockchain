pragma solidity ^0.8.0;

contract TokenBanit {
    mapping(address => uint256) public balances;
    mapping(address => bool) private initialized; // Urmărim utilizatorii care au primit tokenii inițiali
    event TokensSpent(address indexed user, uint256 amount);
    event TokensMinted(address indexed to, uint256 amount);

    uint256 public constant INITIAL_TOKENS = 500;

    constructor() {
    }

    function claimInitialTokens() public {
        require(!initialized[msg.sender], "Tokens already claimed");
        balances[msg.sender] = INITIAL_TOKENS;
        initialized[msg.sender] = true; // Marcăm utilizatorul ca fiind inițializat
        emit TokensMinted(msg.sender, INITIAL_TOKENS);
    }

    function transfer(address to, uint256 amount) external {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount; 
        balances[to] += amount;
        emit TokensSpent(msg.sender, amount);
    }

    function balanceOf(address user) external view returns (uint256) {
        return balances[user];
    }

    function mint(address to, uint256 amount) external {
        require(to != address(0), "Invalid address");
        balances[to] += amount;
        emit TokensMinted(to, amount);
    }
}
