describe "Objector", ->

  beforeEach ->
    @Objector = require 'objector'
    @object =
      foo: 1
      bar:
        baz:
          qux: 2
    @objector = new @Objector(@object)

  describe "#get", ->

    it "can get a value", ->
      expect(@objector.get('foo')).         toBe 1
      expect(@objector.get('bar.baz.qux')). toBe 2


  describe "#getOr", ->

    it "can get a value, or an alternat", ->
      or99 = @objector.getOr(99)
      expect(or99('foo')).         toBe  1, "Found top"
      expect(or99('bar.baz.qux')). toBe  2, "Found nested"
      expect(or99('boo')).         toBe 99, "Alternate value"


  describe "#set", ->

    it "can set a value", ->
      @objector.set('foo', 2)
      expect(@object.foo).toBe 2,              "Single level"

      @objector.set('bar.baz.qux', 99)
      expect(@object.bar.baz.qux).toBe 99,     "Nested exists"

      @objector.set('does.not.exist', 99)
      expect(@object.does.not.exist).toBe 99,  "Nested, does not exist"
