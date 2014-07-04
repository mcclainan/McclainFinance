package com.assetLiability

import org.springframework.dao.DataIntegrityViolationException

class AssetLiabilityController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
	static navigation = [
		[group:"assetLiabilityTabs", action:"list", order:0],
		[action:"create", order:10],	
		[group:"trackingTabs", action:"list", title:"Assets/Liabilities", order:70]
	]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [assetLiabilityInstanceList: AssetLiability.list(params), assetLiabilityInstanceTotal: AssetLiability.count()]
    }

    def create() {
        [assetLiabilityInstance: new AssetLiability(params)]
    }

    def save() {
        def assetLiabilityInstance = new AssetLiability(params)
        if (!assetLiabilityInstance.save(flush: true)) {
            render(view: "create", model: [assetLiabilityInstance: assetLiabilityInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'assetLiability.label', default: 'AssetLiability'), assetLiabilityInstance.id])
        redirect(action: "show", id: assetLiabilityInstance.id)
    }

    def show() {
        def assetLiabilityInstance = AssetLiability.get(params.id)
        if (!assetLiabilityInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'assetLiability.label', default: 'AssetLiability'), params.id])
            redirect(action: "list")
            return
        }

        [assetLiabilityInstance: assetLiabilityInstance]
    }

    def edit() {
        def assetLiabilityInstance = AssetLiability.get(params.id)
        if (!assetLiabilityInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'assetLiability.label', default: 'AssetLiability'), params.id])
            redirect(action: "list")
            return
        }

        [assetLiabilityInstance: assetLiabilityInstance]
    }

    def update() {
        def assetLiabilityInstance = AssetLiability.get(params.id)
        if (!assetLiabilityInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'assetLiability.label', default: 'AssetLiability'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (assetLiabilityInstance.version > version) {
                assetLiabilityInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'assetLiability.label', default: 'AssetLiability')] as Object[],
                          "Another user has updated this AssetLiability while you were editing")
                render(view: "edit", model: [assetLiabilityInstance: assetLiabilityInstance])
                return
            }
        }

        assetLiabilityInstance.properties = params

        if (!assetLiabilityInstance.save(flush: true)) {
            render(view: "edit", model: [assetLiabilityInstance: assetLiabilityInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'assetLiability.label', default: 'AssetLiability'), assetLiabilityInstance.id])
        redirect(action: "show", id: assetLiabilityInstance.id)
    }

    def delete() {
        def assetLiabilityInstance = AssetLiability.get(params.id)
        if (!assetLiabilityInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'assetLiability.label', default: 'AssetLiability'), params.id])
            redirect(action: "list")
            return
        }

        try {
            assetLiabilityInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'assetLiability.label', default: 'AssetLiability'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'assetLiability.label', default: 'AssetLiability'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
