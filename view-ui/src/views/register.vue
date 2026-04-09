<template>
  <div class="register">
    <el-form ref="registerForm" :model="registerForm" :rules="registerRules" class="register-form">
      <h3 class="title">物业管理系统</h3>
      <el-form-item prop="username">
        <el-input v-model="registerForm.username" type="text" auto-complete="off" placeholder="账号">
          <svg-icon slot="prefix" icon-class="user" class="el-input__icon input-icon" />
        </el-input>
      </el-form-item>
      <el-form-item  prop="phonenumber">
        <el-input v-model="registerForm.phonenumber" placeholder="请输入手机号码" maxlength="11" />
      </el-form-item>
      <el-form-item  prop="email">
        <el-input v-model="registerForm.email" placeholder="请输入邮箱" maxlength="50" />
      </el-form-item>
      <el-form-item prop="password">
        <el-input
          v-model="registerForm.password"
          type="password"
          auto-complete="off"
          placeholder="密码"
          @keyup.enter.native="handleRegister"
        >
          <svg-icon slot="prefix" icon-class="password" class="el-input__icon input-icon" />
        </el-input>
      </el-form-item>
      <el-form-item prop="confirmPassword">
        <el-input
          v-model="registerForm.confirmPassword"
          type="password"
          auto-complete="off"
          placeholder="确认密码"
          @keyup.enter.native="handleRegister"
        >
          <svg-icon slot="prefix" icon-class="password" class="el-input__icon input-icon" />
        </el-input>
      </el-form-item>
      <el-form-item>
        <el-select v-model="registerForm.roleId" placeholder="请选择角色">
          <el-option v-for="item in roleOptions" :key="item.roleId" :label="item.roleName" :value="item.roleId" :disabled="item.status == 1"></el-option>
        </el-select>
      </el-form-item>
      <el-form-item prop="code" v-if="captchaEnabled">
        <el-input
          v-model="registerForm.code"
          auto-complete="off"
          placeholder="验证码"
          style="width: 63%"
          @keyup.enter.native="handleRegister"
        >
          <svg-icon slot="prefix" icon-class="validCode" class="el-input__icon input-icon" />
        </el-input>
        <div class="register-code">
          <img :src="codeUrl" @click="getCode" class="register-code-img"/>
        </div>
      </el-form-item>
      <el-form-item style="width:100%;">
        <el-button
          :loading="loading"
          size="medium"
          type="primary"
          style="width:100%;"
          @click.native.prevent="handleRegister"
        >
          <span v-if="!loading">注 册</span>
          <span v-else>注 册 中...</span>
        </el-button>
        <div style="float: right;">
          <router-link class="link-type" :to="'/login'">使用已有账户登录</router-link>
        </div>
      </el-form-item>
    </el-form>
  </div>
</template>

<script>
import { getCodeImg, register } from "@/api/login";
import {nonSystemRoleList} from '@/api/system/role'

export default {
  name: "Register",
  data() {
    const equalToPassword = (rule, value, callback) => {
      if (this.registerForm.password !== value) {
        callback(new Error("两次输入的密码不一致"));
      } else {
        callback();
      }
    };
    return {
      codeUrl: "",
      registerForm: {
        username: "",
        password: "",
        confirmPassword: "",
        code: "",
        uuid: "",
        nickName:"",
        phonenumber:"",
        email:"",
        roleId:""
      },
      // 角色选项
      roleOptions: [],
      registerRules: {
        username: [
          { required: true, trigger: "blur", message: "请输入您的账号" },
          { min: 2, max: 20, message: '用户账号长度必须介于 2 和 20 之间', trigger: 'blur' }
        ],
        password: [
          { required: true, trigger: "blur", message: "请输入您的密码" },
          { min: 5, max: 20, message: "用户密码长度必须介于 5 和 20 之间", trigger: "blur" },
          { pattern: /^[^<>"'|\\]+$/, message: "不能包含非法字符：< > \" ' \\\ |", trigger: "blur" }
        ],
        confirmPassword: [
          { required: true, trigger: "blur", message: "请再次输入您的密码" },
          { required: true, validator: equalToPassword, trigger: "blur" }
        ],
        email: [
          {
            type: "email",
            message: "请输入正确的邮箱地址",
            trigger: ["blur", "change"]
          }
        ],
        nickName: [
          { required: true, message: "用户昵称不能为空", trigger: "blur" }
        ],
        phonenumber: [
          {
            pattern: /^1[3|4|5|6|7|8|9][0-9]\d{8}$/,
            message: "请输入正确的手机号码",
            trigger: "blur"
          }
        ],
        code: [{ required: true, trigger: "change", message: "请输入验证码" }]
      },
      loading: false,
      captchaEnabled: true
    };
  },
  created() {
    this.getCode();
    nonSystemRoleList().then(res => {
      this.roleOptions = res.data
      })
  },
  methods: {
    getCode() {
      getCodeImg().then(res => {
        this.captchaEnabled = res.captchaEnabled === undefined ? true : res.captchaEnabled;
        if (this.captchaEnabled) {
          this.codeUrl = "data:image/gif;base64," + res.img;
          this.registerForm.uuid = res.uuid;
        }
      });
    },
    handleRegister() {
      this.$refs.registerForm.validate(valid => {
        if (valid) {
          this.loading = true;
          register(this.registerForm).then(res => {
            const username = this.registerForm.username;
            this.$alert("<font color='red'>恭喜你，您的账号 " + username + " 注册成功！</font>", '系统提示', {
              dangerouslyUseHTMLString: true,
              type: 'success'
            }).then(() => {
              this.$router.push("/login");
            }).catch(() => {});
          }).catch(() => {
            this.loading = false;
            if (this.captchaEnabled) {
              this.getCode();
            }
          })
        }
      });
    }
  }
};
</script>

<style rel="stylesheet/scss" lang="scss">
.register {
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 100vh;
  background-image: url("../assets/images/login-background.jpg");
  background-size: cover;
  background-position: center;
  background-repeat: no-repeat;
  background-attachment: fixed;
  position: relative;

  &::before {
    content: "";
    position: absolute;
    inset: 0;
    background: rgba(0, 0, 0, 0.4);
    z-index: 1;
  }
}

.title {
  margin: 0px auto 30px auto;
  text-align: center;
  color: #333;
  font-size: 24px;
  font-weight: bold;
}

.register-form {
  position: relative;
  z-index: 2;
  background: #fff;
  border-radius: 16px;
  width: 420px;
  padding: 40px 30px 20px 30px;
  
  /* 清晰边框方案 - 与登录页面保持一致 */
  border: 1.5px solid #dcdfe6;
  box-shadow: 
    0 0 0 0.5px rgba(0, 0, 0, 0.08),
    0 4px 12px rgba(0, 0, 0, 0.08);
  
  .el-input {
    height: 42px;
    input {
      height: 42px;
      border-radius: 8px;
      border: 1px solid #dcdfe6;
      transition: border-color 0.2s;
      
      &:hover {
        border-color: #c0c4cc;
      }
      
      &:focus {
        border-color: #409EFF;
        box-shadow: 0 0 0 1px rgba(64, 158, 255, 0.2);
      }
    }
  }
  
  .input-icon {
    height: 39px;
    width: 14px;
    margin-left: 2px;
  }
  
  .el-select {
    width: 100%;
    
    .el-input {
      input {
        border-radius: 8px;
      }
    }
  }
  
  .el-button {
    border-radius: 8px;
    height: 42px;
    font-weight: 500;
  }
  
  .link-type {
    display: inline-block;
    margin-top: 10px;
    font-size: 14px;
    color: #409EFF;
    text-decoration: none;
    transition: color 0.3s;
    
    &:hover {
      color: #66b1ff;
      text-decoration: underline;
    }
  }
}

.register-tip {
  font-size: 13px;
  text-align: center;
  color: #bfbfbf;
}

.register-code {
  width: 33%;
  height: 38px;
  float: right;
  
  img {
    cursor: pointer;
    vertical-align: middle;
    border: 1px solid #dcdfe6;
    border-radius: 6px;
  }
}

.el-register-footer {
  height: 40px;
  line-height: 40px;
  position: fixed;
  bottom: 0;
  width: 100%;
  text-align: center;
  color: #fff;
  font-family: Arial;
  font-size: 12px;
  letter-spacing: 1px;
}

.register-code-img {
  height: 38px;
}
</style>