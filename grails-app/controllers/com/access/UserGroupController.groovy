package com.access

import org.springframework.dao.DataIntegrityViolationException

class UserGroupController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [userGroupInstanceList: UserGroup.list(params), userGroupInstanceTotal: UserGroup.count()]
    }

    def create() {
        [userGroupInstance: new UserGroup(params)]
    }

    def save() {
        def userGroupInstance = new UserGroup(params)
        if (!userGroupInstance.save(flush: true)) {
            render(view: "create", model: [userGroupInstance: userGroupInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'userGroup.label', default: 'UserGroup'), userGroupInstance.id])
        redirect(action: "show", id: userGroupInstance.id)
    }

    def show() {
        def userGroupInstance = UserGroup.get(params.id)
        if (!userGroupInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'userGroup.label', default: 'UserGroup'), params.id])
            redirect(action: "list")
            return
        }

        [userGroupInstance: userGroupInstance]
    }

    def edit() {
        def userGroupInstance = UserGroup.get(params.id)
        if (!userGroupInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'userGroup.label', default: 'UserGroup'), params.id])
            redirect(action: "list")
            return
        }

        [userGroupInstance: userGroupInstance]
    }

    def update() {
        def userGroupInstance = UserGroup.get(params.id)
        if (!userGroupInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'userGroup.label', default: 'UserGroup'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (userGroupInstance.version > version) {
                userGroupInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'userGroup.label', default: 'UserGroup')] as Object[],
                          "Another user has updated this UserGroup while you were editing")
                render(view: "edit", model: [userGroupInstance: userGroupInstance])
                return
            }
        }

        userGroupInstance.properties = params

        if (!userGroupInstance.save(flush: true)) {
            render(view: "edit", model: [userGroupInstance: userGroupInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'userGroup.label', default: 'UserGroup'), userGroupInstance.id])
        redirect(action: "show", id: userGroupInstance.id)
    }

    def delete() {
        def userGroupInstance = UserGroup.get(params.id)
        if (!userGroupInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'userGroup.label', default: 'UserGroup'), params.id])
            redirect(action: "list")
            return
        }

        try {
            userGroupInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'userGroup.label', default: 'UserGroup'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'userGroup.label', default: 'UserGroup'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
