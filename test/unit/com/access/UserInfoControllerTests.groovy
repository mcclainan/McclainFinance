package com.access



import org.junit.*
import grails.test.mixin.*

@TestFor(UserInfoController)
@Mock(UserInfo)
class UserInfoControllerTests {


    def populateValidParams(params) {
      assert params != null
      // TODO: Populate valid properties like...
      //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/userInfo/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.userInfoInstanceList.size() == 0
        assert model.userInfoInstanceTotal == 0
    }

    void testCreate() {
       def model = controller.create()

       assert model.userInfoInstance != null
    }

    void testSave() {
        controller.save()

        assert model.userInfoInstance != null
        assert view == '/userInfo/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/userInfo/show/1'
        assert controller.flash.message != null
        assert UserInfo.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/userInfo/list'


        populateValidParams(params)
        def userInfo = new UserInfo(params)

        assert userInfo.save() != null

        params.id = userInfo.id

        def model = controller.show()

        assert model.userInfoInstance == userInfo
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/userInfo/list'


        populateValidParams(params)
        def userInfo = new UserInfo(params)

        assert userInfo.save() != null

        params.id = userInfo.id

        def model = controller.edit()

        assert model.userInfoInstance == userInfo
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/userInfo/list'

        response.reset()


        populateValidParams(params)
        def userInfo = new UserInfo(params)

        assert userInfo.save() != null

        // test invalid parameters in update
        params.id = userInfo.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/userInfo/edit"
        assert model.userInfoInstance != null

        userInfo.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/userInfo/show/$userInfo.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        userInfo.clearErrors()

        populateValidParams(params)
        params.id = userInfo.id
        params.version = -1
        controller.update()

        assert view == "/userInfo/edit"
        assert model.userInfoInstance != null
        assert model.userInfoInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/userInfo/list'

        response.reset()

        populateValidParams(params)
        def userInfo = new UserInfo(params)

        assert userInfo.save() != null
        assert UserInfo.count() == 1

        params.id = userInfo.id

        controller.delete()

        assert UserInfo.count() == 0
        assert UserInfo.get(userInfo.id) == null
        assert response.redirectedUrl == '/userInfo/list'
    }
}
