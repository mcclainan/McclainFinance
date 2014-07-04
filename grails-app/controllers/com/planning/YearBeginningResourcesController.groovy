package com.planning

import org.springframework.dao.DataIntegrityViolationException

class YearBeginningResourcesController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [yearBeginningResourcesInstanceList: YearBeginningResources.list(params), yearBeginningResourcesInstanceTotal: YearBeginningResources.count()]
    }

    def create() {
        [yearBeginningResourcesInstance: new YearBeginningResources(params)]
    }

    def save() {
        def yearBeginningResourcesInstance = new YearBeginningResources(params)
        if (!yearBeginningResourcesInstance.save(flush: true)) {
            render(view: "create", model: [yearBeginningResourcesInstance: yearBeginningResourcesInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'yearBeginningResources.label', default: 'YearBeginningResources'), yearBeginningResourcesInstance.id])
        redirect(action: "show", id: yearBeginningResourcesInstance.id)
    }

    def show() {
        def yearBeginningResourcesInstance = YearBeginningResources.get(params.id)
        if (!yearBeginningResourcesInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'yearBeginningResources.label', default: 'YearBeginningResources'), params.id])
            redirect(action: "list")
            return
        }

        [yearBeginningResourcesInstance: yearBeginningResourcesInstance]
    }

    def edit() {
        def yearBeginningResourcesInstance = YearBeginningResources.get(params.id)
        if (!yearBeginningResourcesInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'yearBeginningResources.label', default: 'YearBeginningResources'), params.id])
            redirect(action: "list")
            return
        }

        [yearBeginningResourcesInstance: yearBeginningResourcesInstance]
    }

    def update() {
        def yearBeginningResourcesInstance = YearBeginningResources.get(params.id)
        if (!yearBeginningResourcesInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'yearBeginningResources.label', default: 'YearBeginningResources'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (yearBeginningResourcesInstance.version > version) {
                yearBeginningResourcesInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'yearBeginningResources.label', default: 'YearBeginningResources')] as Object[],
                          "Another user has updated this YearBeginningResources while you were editing")
                render(view: "edit", model: [yearBeginningResourcesInstance: yearBeginningResourcesInstance])
                return
            }
        }

        yearBeginningResourcesInstance.properties = params

        if (!yearBeginningResourcesInstance.save(flush: true)) {
            render(view: "edit", model: [yearBeginningResourcesInstance: yearBeginningResourcesInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'yearBeginningResources.label', default: 'YearBeginningResources'), yearBeginningResourcesInstance.id])
        redirect(action: "show", id: yearBeginningResourcesInstance.id)
    }

    def delete() {
        def yearBeginningResourcesInstance = YearBeginningResources.get(params.id)
        if (!yearBeginningResourcesInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'yearBeginningResources.label', default: 'YearBeginningResources'), params.id])
            redirect(action: "list")
            return
        }

        try {
            yearBeginningResourcesInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'yearBeginningResources.label', default: 'YearBeginningResources'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'yearBeginningResources.label', default: 'YearBeginningResources'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
