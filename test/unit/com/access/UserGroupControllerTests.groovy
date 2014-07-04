package com.access



import org.junit.*
import grails.test.mixin.*

@TestFor(UserGroupController)
@Mock(UserGroup)
class UserGroupControllerTests {


    def populateValidParams(params) {
      assert params != null
      // TODO: Populate valid properties like...
      //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/userGroup/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.userGroupInstanceList.size() == 0
        assert model.userGroupInstanceTotal == 0
    }

    void testCreate() {
       def model = controller.create()

       assert model.userGroupInstance != null
    }

    void testSave() {
        controller.save()

        assert model.userGroupInstance != null
        assert view == '/userGroup/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/userGroup/show/1'
        assert controller.flash.message != null
        assert UserGroup.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/userGroup/list'


        populateValidParams(params)
        def userGroup = new UserGroup(params)

        assert userGroup.save() != null

        params.id = userGroup.id

        def model = controller.show()

        assert model.userGroupInstance == userGroup
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/userGroup/list'


        populateValidParams(params)
        def userGroup = new UserGroup(params)

        assert userGroup.save() != null

        params.id = userGroup.id

        def model = controller.edit()

        assert model.userGroupInstance == userGroup
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/userGroup/list'

        response.reset()


        populateValidParams(params)
        def userGroup = new UserGroup(params)

        assert userGroup.save() != null

        // test invalid parameters in update
        params.id = userGroup.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/userGroup/edit"
        assert model.userGroupInstance != null

        userGroup.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/userGroup/show/$userGroup.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        userGroup.clearErrors()

        populateValidParams(params)
        params.id = userGroup.id
        params.version = -1
        controller.update()

        assert view == "/userGroup/edit"
        assert model.userGroupInstance != null
        assert model.userGroupInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/userGroup/list'

        response.reset()

        populateValidParams(params)
        def userGroup = new UserGroup(params)

        assert userGroup.save() != null
        assert UserGroup.count() == 1

        params.id = userGroup.id

        controller.delete()

        assert UserGroup.count() == 0
        assert UserGroup.get(userGroup.id) == null
        assert response.redirectedUrl == '/userGroup/list'
    }
}
