<template>
  <div class="login">
    <el-form ref="loginForm" :model="loginForm" :rules="loginRules" class="login-form">
      <h3 class="title">物业管理系统</h3>
      <el-form-item prop="username">
        <el-input
          v-model="loginForm.username"
          type="text"
          auto-complete="off"
          placeholder="账号"
        >
          <svg-icon slot="prefix" icon-class="user" class="el-input__icon input-icon" />
        </el-input>
      </el-form-item>
      <el-form-item prop="password">
        <el-input
          v-model="loginForm.password"
          type="password"
          auto-complete="off"
          placeholder="密码"
          @keyup.enter.native="handleLogin"
        >
          <svg-icon slot="prefix" icon-class="password" class="el-input__icon input-icon" />
        </el-input>
      </el-form-item>
      <el-form-item prop="code" v-if="captchaEnabled">
        <el-input
          v-model="loginForm.code"
          auto-complete="off"
          placeholder="验证码"
          style="width: 63%"
          @keyup.enter.native="handleLogin"
        >
          <svg-icon slot="prefix" icon-class="validCode" class="el-input__icon input-icon" />
        </el-input>
        <div class="login-code">
          <img :src="codeUrl" @click="getCode" class="login-code-img"/>
        </div>
      </el-form-item>
      <el-checkbox v-model="loginForm.rememberMe" style="margin:0px 0px 25px 0px;">记住密码</el-checkbox>
      <el-form-item style="width:100%;">
        <el-button
          :loading="loading"
          size="medium"
          type="primary"
          style="width:100%;"
          @click.native.prevent="handleLogin"
        >
          <span v-if="!loading">登 录</span>
          <span v-else>登 录 中...</span>
        </el-button>
        <el-form-item style="width:100%; text-align: center;">
          <router-link class="register-btn" to="/register">
            还没有账号？<span class="register-highlight">立即注册</span>
          </router-link>
        </el-form-item>
      </el-form-item>
    </el-form>
  </div>
</template>

<script>
import { getCodeImg } from "@/api/login";
import Cookies from "js-cookie";
import { encrypt, decrypt } from '@/utils/jsencrypt'

export default {
  name: "Login",
  data() {
    return {
      codeUrl: "",
      loginForm: {
        username: "",
        password: "",
        rememberMe: false,
        code: "",
        uuid: ""
      },
      loginRules: {
        username: [
          { required: true, trigger: "blur", message: "请输入您的账号" }
        ],
        password: [
          { required: true, trigger: "blur", message: "请输入您的密码" }
        ],
        code: [{ required: true, trigger: "change", message: "请输入验证码" }]
      },
      loading: false,
      // 验证码开关
      captchaEnabled: true,
      // 注册开关
      register: false,
      redirect: undefined
    };
  },
  watch: {
    $route: {
      handler: function(route) {
        this.redirect = route.query && route.query.redirect;
      },
      immediate: true
    }
  },
  created() {
    this.getCode();
    this.getCookie();
  },
  methods: {
    getCode() {
      getCodeImg().then(res => {
        this.captchaEnabled = res.captchaEnabled === undefined ? true : res.captchaEnabled;
        if (this.captchaEnabled) {
          this.codeUrl = "data:image/gif;base64," + res.img;
          this.loginForm.uuid = res.uuid;
        }
      });
    },
    getCookie() {
      const username = Cookies.get("username");
      const password = Cookies.get("password");
      const rememberMe = Cookies.get('rememberMe')
      this.loginForm = {
        username: username === undefined ? this.loginForm.username : username,
        password: password === undefined ? this.loginForm.password : decrypt(password),
        rememberMe: rememberMe === undefined ? false : Boolean(rememberMe)
      };
    },
    handleLogin() {
      this.$refs.loginForm.validate(valid => {
        if (valid) {
          this.loading = true;
          if (this.loginForm.rememberMe) {
            Cookies.set("username", this.loginForm.username, { expires: 30 });
            Cookies.set("password", encrypt(this.loginForm.password), { expires: 30 });
            Cookies.set('rememberMe', this.loginForm.rememberMe, { expires: 30 });
          } else {
            Cookies.remove("username");
            Cookies.remove("password");
            Cookies.remove('rememberMe');
          }
          this.$store.dispatch("Login", this.loginForm).then(() => {
            this.$router.push({ path: this.redirect || "/" }).catch(()=>{});
          }).catch(() => {
            this.loading = false;
            if (this.captchaEnabled) {
              this.getCode();
            }
          });
        }
      });
    }
  }
};
</script>

<style rel="stylesheet/scss" lang="scss">
.login {
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

  .login-form {
    position: relative;
    z-index: 2;
    background: #fff;
    border-radius: 16px;
    width: 420px;
    padding: 40px 30px 20px 30px;
    
    /* 清晰边框方案 - 在浅色背景下也清晰可见 */
    border: 1.5px solid #dcdfe6;
    box-shadow: 
      0 0 0 0.5px rgba(0, 0, 0, 0.08),
      0 4px 12px rgba(0, 0, 0, 0.08);

    .title {
      margin-bottom: 30px;
      text-align: center;
      font-size: 24px;
      color: #333;
      font-weight: bold;
    }

    .el-input {
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
      margin-left: 5px;
      color: #999;
    }

    .login-code {
      width: 34%;
      float: right;

      img {
        height: 42px;
        border-radius: 6px;
        cursor: pointer;
        border: 1px solid #dcdfe6;
      }
    }

    .el-button {
      border-radius: 8px;
      height: 42px;
      font-weight: 500;
    }
  }

  .el-login-footer {
    position: absolute;
    bottom: 10px;
    width: 100%;
    text-align: center;
    color: #ddd;
    font-size: 12px;
    z-index: 2;
  }
}

.register-btn {
  display: inline-block;
  margin-top: 10px;
  font-size: 14px;
  color: #999;
  text-decoration: none;

  .register-highlight {
    color: #409EFF;
    font-weight: 500;
    margin-left: 4px;
    transition: color 0.3s;

    &:hover {
      color: #66b1ff;
    }
  }
}

.login-code-img {
  height: 38px;
}
</style>