package com.assetLiability

import org.springframework.dao.DataIntegrityViolationException

class AssetLiabilityClassController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
	
	static navigation = [
		[group:"assetLiabiiltyClassTabs", action:"list", order:0],
		[action:"create", order:10],
		[group:"assetLiabilityTabs", action:"list", title:"Asset/Liability Class", order:0]
	]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [assetLiabilityClassInstanceList: AssetLiabilityClass.list(params), assetLiabilityClassInstanceTotal: AssetLiabilityClass.count()]
    }

    def create() {
        [assetLiabilityClassInstance: new AssetLiabilityClass(params)]
    }

    def save() {
        def assetLiabilityClassInstance = new AssetLiabilityClass(params)
        if (!assetLiabilityClassInstance.save(flush: true)) {
            render(view: "create", model: [assetLiabilityClassInstance: assetLiabilityClassInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'assetLiabilityClass.label', default: 'AssetLiabilityClass'), assetLiabilityClassInstance.id])
        redirect(action: "show", id: assetLiabilityClassInstance.id)
    }

    def show() {
        def assetLiabilityClassInstance = AssetLiabilityClass.get(params.id)
        if (!assetLiabilityClassInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'assetLiabilityClass.label', default: 'AssetLiabilityClass'), params.id])
            redirect(action: "list")
            return
        }

        [assetLiabilityClassInstance: assetLiabilityClassInstance]
    }

    def edit() {
        def assetLiabilityClassInstance = AssetLiabilityClass.get(params.id)
        if (!assetLiabilityClassInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'assetLiabilityClass.label', default: 'AssetLiabilityClass'), params.id])
            redirect(action: "list")
            return
        }

        [assetLiabilityClassInstance: assetLiabilityClassInstance]
    }

    def update() {
        def assetLiabilityClassInstance = AssetLiabilityClass.get(params.id)
        if (!assetLiabilityClassInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'assetLiabilityClass.label', default: 'AssetLiabilityClass'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (assetLiabilityClassInstance.version > version) {
                assetLiabilityClassInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'assetLiabilityClass.label', default: 'AssetLiabilityClass')] as Object[],
                          "Another user has updated this AssetLiabilityClass while you were editing")
                render(view: "edit", model: [assetLiabilityClassInstance: assetLiabilityClassInstance])
                return
            }
        }

        assetLiabilityClassInstance.properties = params

        if (!assetLiabilityClassInstance.save(flush: true)) {
            render(view: "edit", model: [assetLiabilityClassInstance: assetLiabilityClassInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'assetLiabilityClass.label', default: 'AssetLiabilityClass'), assetLiabilityClassInstance.id])
        redirect(action: "show", id: assetLiabilityClassInstance.id)
    }

    def delete() {
        def assetLiabilityClassInstance = AssetLiabilityClass.get(params.id)
        if (!assetLiabilityClassInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'assetLiabilityClass.label', default: 'AssetLiabilityClass'), params.id])
            redirect(action: "list")
            return
        }

        try {
            assetLiabilityClassInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'assetLiabilityClass.label', default: 'AssetLiabilityClass'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'assetLiabilityClass.label', default: 'AssetLiabilityClass'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
