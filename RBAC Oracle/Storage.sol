// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.4.21;
pragma experimental ABIEncoderV2;

contract RolePermissionBySol{

   struct Role_table{
      //定义角色结构体结构体，存入权限id，每个U_id对应一个Per_id的映射，len存储权限列表的长度
        string U_id;
        uint Per_id;
        // uint len;
    }
    mapping(string=>Role_table) rt;

    function S_table_add(string memory U_id, uint Per_id) public {
      //U_id和Per_id的键值对增加
        // bytes memory b = bytes(U_id);
        rt[U_id].U_id=U_id;
        rt[U_id].Per_id=Per_id;
        // rt.[U_id].len++;
    }

    function getPer_idByU_id(string memory U_id) public view returns(uint){
      //根据U_id获取对应Per_id
        // bytes memory b = bytes(U_id);
        return rt[U_id].Per_id;
    }

    function del_U_id(string memory U_id)public{
      //删除记录
        delete rt[U_id];
    }

    function mod_Per_id(string memory U_id, uint Per_id)public{
      //记录修改
        rt[U_id].Per_id = Per_id;
    }

    mapping (address => uint) public balanceOf;
 
    function setBlance(address _address, string memory U_id) public returns (uint) {
        balanceOf[_address] = rt[U_id].Per_id;
        return balanceOf[_address];
    }

}


contract Evidence{
    uint CODE_SUCCESS = 0;
    uint FILE_NOT_EXIST = 3002;
    uint FILE_ALREADY_EXIST  = 3003;
    uint USER_NOT_EXIST = 3004;
    // 定义数据结构体  
    struct FileEvidence{
    string fileHash;   //文件哈希  
    string author;   //文件作者
    string time;  //文件时间
    string fileName;       //论文名
    }
 
    mapping(string => FileEvidence) filemap;

    // 定义事件 
    event updateInfo(string fileHash, string author, string fileName,string time);


    address[] userList;
    
    function saveEvidence(string memory fileHash,string memory author, string memory fileName,string memory time) public returns(uint code){
        //get filemap under sender
        FileEvidence storage fileEvidence = filemap[fileName];
        fileEvidence.fileHash = fileHash;
        fileEvidence.author = author;
        fileEvidence.time = time;
        fileEvidence.fileName = fileName;
        // filemap[fileHash] = fileEvidence;
        // emit updateInfo(fileEvidence.fileHash,fileEvidence.fileUploadTime,fileEvidence.owner);
        return CODE_SUCCESS;
    }

    mapping (address => uint) public tmp;
    RolePermissionBySol rolePermissionBySol;

    //function ControlContract(address _rolePermissionBySolAddr) public {
    //    rolePermissionBySol = RolePermissionBySol(_rolePermissionBySolAddr);
    //}

     //0x0b7fc2e3E23D3c85c6A4E3DBd45e2c1ac803cD09
    //function getEvidence(string memory fileName, uint RoleID)  public returns(uint)
    function getEvidence(address _rolePermissionBySolAddr, string memory fileName, string memory U_id)  public returns(uint) {
        //get filemap under sender
        rolePermissionBySol = RolePermissionBySol(_rolePermissionBySolAddr);
        //rolePermissionBySol.setBlance(_rolePermissionBySolAddr, RoleID);
        tmp[_rolePermissionBySolAddr] = rolePermissionBySol.setBlance(_rolePermissionBySolAddr, U_id);
        FileEvidence memory fileEvidence = filemap[fileName];
        return tmp[_rolePermissionBySolAddr];
    }

}