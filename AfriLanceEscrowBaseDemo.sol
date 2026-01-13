// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract AfriLanceEscrowBaseDemo {
    address public immutable client;
    address public immutable freelancer;
    address public immutable oracleAddress;  // For future off-chain AI/oracle updates

    uint256 public amount;
    bool public workCompleted;
    bool public fundsReleased;

    // Oracle placeholder for AI-predicted data
    uint256 public aiMatchScore;  // AI-predicted match confidence (0-100)

    event Deposited(uint256 amount);
    event WorkCompleted();
    event FundsReleased(address to, uint256 amount);
    event Refunded(address to, uint256 amount);
    event AIMatchScoreUpdated(uint256 score);

    constructor(address _freelancer, address _oracle) {
        client = msg.sender;
        freelancer = _freelancer;
        oracleAddress = _oracle;  // A dummy oracle address
        workCompleted = false;
        fundsReleased = false;
        amount = 0;
        aiMatchScore = 0;
    }

    function deposit() external payable {
        require(msg.sender == client, "Only client can deposit");
        require(amount == 0, "Already deposited");
        require(msg.value > 0, "Must deposit some amount");

        amount = msg.value;
        emit Deposited(msg.value);
    }

    function completeWork() external {
        require(msg.sender == freelancer, "Only freelancer");
        require(!workCompleted, "Already complete");
        require(amount > 0, "No funds deposited");

        workCompleted = true;
        emit WorkCompleted();
    }

    function approveRelease() external {
        require(msg.sender == client, "Only client");
        require(workCompleted, "Not completed");
        require(!fundsReleased, "Already released");

        fundsReleased = true;
        (bool sent, ) = freelancer.call{value: address(this).balance}("");
        require(sent, "Send failed");

        emit FundsReleased(freelancer, address(this).balance);
    }

    function refund() external {
        require(msg.sender == client, "Only client");
        require(!workCompleted, "Cannot refund after completion");

        uint256 bal = address(this).balance;
        (bool sent, ) = client.call{value: bal}("");
        require(sent, "Refund failed");

        emit Refunded(client, bal);
    }

    // Oracle-only update (demo: dummy address)
    function updateAIMatchScore(uint256 _score) external {
        require(msg.sender == oracleAddress, "Only oracle can update");
        require(_score <= 100, "Score must be 0-100");

        aiMatchScore = _score;
        emit AIMatchScoreUpdated(_score);
    }

    function getAIMatchScore() external view returns (uint256) {
        return aiMatchScore;
    }

    // Simple placeholder "AI simulation" function (pure, no storage)
    // Returns a deterministic score based on input strings (for demo purposes)
    function simulateAIMatch(string memory freelancerSkills, string memory jobRequirements) 
        external pure returns (uint256) {
        bytes32 hash1 = keccak256(abi.encodePacked(freelancerSkills));
        bytes32 hash2 = keccak256(abi.encodePacked(jobRequirements));
        uint256 combined = uint256(hash1 ^ hash2);
        return (combined % 101);  // Returns 0-100
    }

    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }
}