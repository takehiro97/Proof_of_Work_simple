// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.0;

contract SimpleBank{
    //mappingはキーと値のペアを保存するデータ構造の関数
    mapping (address => uint) balances;
    
    //deposit関数は、スマートコントラクトにユーザーからETHを預け入れるための関数
    function deposit() public payable{
        balances[msg.sender] += msg.value;
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

    }
}
