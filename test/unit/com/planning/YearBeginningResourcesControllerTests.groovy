package com.planning



import org.junit.*
import grails.test.mixin.*

@TestFor(YearBeginningResourcesController)
@Mock(YearBeginningResources)
class YearBeginningResourcesControllerTests {


    def populateValidParams(params) {
      assert params != null
      // TODO: Populate valid properties like...
      //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/yearBeginningResources/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.yearBeginningResourcesInstanceList.size() == 0
        assert model.yearBeginningResourcesInstanceTotal == 0
    }

    void testCreate() {
       def model = controller.create()

       assert model.yearBeginningResourcesInstance != null
    }

    void testSave() {
        controller.save()

        assert model.yearBeginningResourcesInstance != null
        assert view == '/yearBeginningResources/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/yearBeginningResources/show/1'
        assert controller.flash.message != null
        assert YearBeginningResources.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/yearBeginningResources/list'


        populateValidParams(params)
        def yearBeginningResources = new YearBeginningResources(params)

        assert yearBeginningResources.save() != null

        params.id = yearBeginningResources.id

        def model = controller.show()

        assert model.yearBeginningResourcesInstance == yearBeginningResources
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/yearBeginningResources/list'


        populateValidParams(params)
        def yearBeginningResources = new YearBeginningResources(params)

        assert yearBeginningResources.save() != null

        params.id = yearBeginningResources.id

        def model = controller.edit()

        assert model.yearBeginningResourcesInstance == yearBeginningResources
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/yearBeginningResources/list'

        response.reset()


        populateValidParams(params)
        def yearBeginningResources = new YearBeginningResources(params)

        assert yearBeginningResources.save() != null

        // test invalid parameters in update
        params.id = yearBeginningResources.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/yearBeginningResources/edit"
        assert model.yearBeginningResourcesInstance != null

        yearBeginningResources.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/yearBeginningResources/show/$yearBeginningResources.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        yearBeginningResources.clearErrors()

        populateValidParams(params)
        params.id = yearBeginningResources.id
        params.version = -1
        controller.update()

        assert view == "/yearBeginningResources/edit"
        assert model.yearBeginningResourcesInstance != null
        assert model.yearBeginningResourcesInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/yearBeginningResources/list'

        response.reset()

        populateValidParams(params)
        def yearBeginningResources = new YearBeginningResources(params)

        assert yearBeginningResources.save() != null
        assert YearBeginningResources.count() == 1

        params.id = yearBeginningResources.id

        controller.delete()

        assert YearBeginningResources.count() == 0
        assert YearBeginningResources.get(yearBeginningResources.id) == null
        assert response.redirectedUrl == '/yearBeginningResources/list'
    }
}
