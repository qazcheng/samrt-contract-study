pragma solidity ^0.5.8;
pragma experimental ABIEncoderV2;
contract Calculator {

    address public user;

    //uint256 public PermissionID;

    struct Role_table{
        //定义角色结构体结构体，存入权限id，每个U_id对应一个Per_id的映射
        uint256 R_id;
        uint256 Per_id;
    }
    mapping(uint256=>Role_table) public rt;

    event GetPer_idByR_id(uint256 R_id);
    event Del_R_id(uint256 R_id);
    event Mod_Per_id(uint256 R_id, uint256 Per_id);

    function Table_add(uint256 R_id, uint256 Per_id) public returns(bool){
        //U_id和Per_id的键值对增加
        rt[R_id].R_id=R_id;
        rt[R_id].Per_id=Per_id;
        user = msg.sender;
        return true;
    }

    function getPer_idByR_id(uint256 R_id) public returns(uint256){
        //根据U_id获取对应Per_id
        //PermissionID = rt[R_id].Per_id;

        emit GetPer_idByR_id(R_id);
        user = msg.sender;

        return rt[R_id].Per_id;
    }

    function del_R_id(uint256 R_id)public returns(bool){
        //删除记录
        delete rt[R_id];
        emit Del_R_id(R_id);
        user = msg.sender;
        return true;
    }

    function mod_Per_id(uint256 R_id, uint Per_id)public returns(bool){
      //记录修改
        rt[R_id].Per_id = Per_id;
        emit Mod_Per_id(R_id, Per_id);
        user = msg.sender;
    }
}