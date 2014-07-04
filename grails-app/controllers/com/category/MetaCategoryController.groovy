package com.category

import org.springframework.dao.DataIntegrityViolationException

class MetaCategoryController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
	static navigation = [
		[group:"metaCategoryTabs", action:"list", order:0],
		[action:"create"],
		[group:"categoryTabs", action:"list", title:"Meta Category", order:30]
	]
    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [metaCategoryInstanceList: MetaCategory.list(params), metaCategoryInstanceTotal: MetaCategory.count()]
    }

    def create() {
        [metaCategoryInstance: new MetaCategory(params)]
    }

    def save() {
        def metaCategoryInstance = new MetaCategory(params)
        if (!metaCategoryInstance.save(flush: true)) {
            render(view: "create", model: [metaCategoryInstance: metaCategoryInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'metaCategory.label', default: 'MetaCategory'), metaCategoryInstance.id])
        redirect(action: "show", id: metaCategoryInstance.id)
    }

    def show() {
        def metaCategoryInstance = MetaCategory.get(params.id)
        if (!metaCategoryInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'metaCategory.label', default: 'MetaCategory'), params.id])
            redirect(action: "list")
            return
        }

        [metaCategoryInstance: metaCategoryInstance]
    }

    def edit() {
        def metaCategoryInstance = MetaCategory.get(params.id)
        if (!metaCategoryInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'metaCategory.label', default: 'MetaCategory'), params.id])
            redirect(action: "list")
            return
        }

        [metaCategoryInstance: metaCategoryInstance]
    }

    def update() {
        def metaCategoryInstance = MetaCategory.get(params.id)
        if (!metaCategoryInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'metaCategory.label', default: 'MetaCategory'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (metaCategoryInstance.version > version) {
                metaCategoryInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'metaCategory.label', default: 'MetaCategory')] as Object[],
                          "Another user has updated this MetaCategory while you were editing")
                render(view: "edit", model: [metaCategoryInstance: metaCategoryInstance])
                return
            }
        }

        metaCategoryInstance.properties = params

        if (!metaCategoryInstance.save(flush: true)) {
            render(view: "edit", model: [metaCategoryInstance: metaCategoryInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'metaCategory.label', default: 'MetaCategory'), metaCategoryInstance.id])
        redirect(action: "show", id: metaCategoryInstance.id)
    }

    def delete() {
        def metaCategoryInstance = MetaCategory.get(params.id)
        if (!metaCategoryInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'metaCategory.label', default: 'MetaCategory'), params.id])
            redirect(action: "list")
            return
        }

        try {
            metaCategoryInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'metaCategory.label', default: 'MetaCategory'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'metaCategory.label', default: 'MetaCategory'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
