// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.0;

contract SimpleBank{
    //オーナーだけが設定できるアドレス
    address public owner;

    //mappingはキーと値のペアを保存するデータ構造の関数
    mapping (address => uint) balances;
    
    //ロックされるアカウントのmapping作成
    mapping(address => bool) private lockedAccounts;

    //イベント定義
    event Deposit(address indexed user, uint amount);
    event Withdraw(address indexed user, uint amount);
    event Transfer(address indexed from, address indexed to,uint amount);
    event AccountLocked(address indexed user);
    event AccountUnlocked(address indexed user);

    //送信者がオーナーか判断する機能
    modifier onlyOwner(){
        require(msg.sender == owner, "Not the owner");
        _;
    }

    //口座がロックされてるか判断する機能
    modifier notLocked(){
        require(!lockedAccounts[msg.sender],"Account is locked");
        _;
    }

    //アカウントをロックする機能
    function lockAccount(address user)external onlyOwner{
        lockedAccounts[user] = true;
        emit AccountLocked(user);
    }

    //アカウントをアンロックする機能
    function unlockAccount(address user) external onlyOwner{
        lockedAccounts[user] = false;
        emit AccountUnlocked(user);
    }
    
    //deposit関数は、スマートコントラクトにユーザーからETHを預け入れるための関数
    function deposit() public payable{
        balances[msg.sender] += msg.value;

        // deposit関数の履歴を残す関数
        emit Deposit(msg.sender, msg.value);
    }

    /*
    withdrawは残高を引き出す機能
    withdraw()だと全額送る機能になるため(uint amount)によって
    額を指定できるようにする
    */
    function  withdraw(uint amount) public{
        require(balances[msg.sender] >= amount, "Not enough balance") ;
        balances[msg.sender] -= amount;

        // payableで送金可能なアドレス型に変換し、callでETHを送る
        (bool success,) = payable(msg.sender).call{value: amount}("");
        require(success, "Withdraw failed"); //送金成功チェック
        
        // withdraw関数の履歴を残す関数
        emit Withdraw(msg.sender, amount);
    }

    // transfer関数はETHを送る関数
    function transfer(address to, uint amount) public{
        //残高が足りてるかチェック
        require(balances[msg.sender] >= amount, "Not enought balance");
        
        //自分の残高から引く
        balances[msg.sender] -= amount;
        
        //相手の残高に加える
        balances[to] += amount;

        //transfer関数の履歴を残す関数
        emit Transfer(msg.sender, to, amount);
    }

    //残高を確認する関数
    function getBalance() external view returns (uint){
        return balances[msg.sender];
    }
    
}
