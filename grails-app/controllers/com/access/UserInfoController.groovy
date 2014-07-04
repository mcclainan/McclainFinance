package com.access

import org.springframework.dao.DataIntegrityViolationException

class UserInfoController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [userInfoInstanceList: UserInfo.list(params), userInfoInstanceTotal: UserInfo.count()]
    }

    def create() {
        [userInfoInstance: new UserInfo(params)]
    }

    def save() {
        def userInfoInstance = new UserInfo(params)
        if (!userInfoInstance.save(flush: true)) {
            render(view: "create", model: [userInfoInstance: userInfoInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'userInfo.label', default: 'UserInfo'), userInfoInstance.id])
        redirect(action: "show", id: userInfoInstance.id)
    }

    def show() {
        def userInfoInstance = UserInfo.get(params.id)
        if (!userInfoInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'userInfo.label', default: 'UserInfo'), params.id])
            redirect(action: "list")
            return
        }

        [userInfoInstance: userInfoInstance]
    }

    def edit() {
        def userInfoInstance = UserInfo.get(params.id)
        if (!userInfoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'userInfo.label', default: 'UserInfo'), params.id])
            redirect(action: "list")
            return
        }

        [userInfoInstance: userInfoInstance]
    }

    def update() {
        def userInfoInstance = UserInfo.get(params.id)
        if (!userInfoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'userInfo.label', default: 'UserInfo'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (userInfoInstance.version > version) {
                userInfoInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'userInfo.label', default: 'UserInfo')] as Object[],
                          "Another user has updated this UserInfo while you were editing")
                render(view: "edit", model: [userInfoInstance: userInfoInstance])
                return
            }
        }

        userInfoInstance.properties = params

        if (!userInfoInstance.save(flush: true)) {
            render(view: "edit", model: [userInfoInstance: userInfoInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'userInfo.label', default: 'UserInfo'), userInfoInstance.id])
        redirect(action: "show", id: userInfoInstance.id)
    }

    def delete() {
        def userInfoInstance = UserInfo.get(params.id)
        if (!userInfoInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'userInfo.label', default: 'UserInfo'), params.id])
            redirect(action: "list")
            return
        }

        try {
            userInfoInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'userInfo.label', default: 'UserInfo'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'userInfo.label', default: 'UserInfo'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
	
	def login(){}
	
	def signin(){
		def errors = [:]
		
		def user = UserInfo.withCriteria {
			eq("name",params.name,[ignoreCase:true])
		}.get(0)
		
		
		if(user){
			if(user.password == params.password){
				session.user = user;
				render(uri:"/")
			}else{
				errors."invalid" = "User name and password did not match"
				render(view:"login",model:[name:params.name,errors:errors])
				return
			}
		}else{
			errors."notfound" = "User name ${params.name} could not be found"
			render(view:"login",model:[name:params.name,errors:errors])
			return
		}
	}
}
