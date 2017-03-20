hiddenInput = (name,value)->
  $("<input>")
    .attr({
      "type":"hidden"
      "name":name
    })
    .val(value)

ready = ->

  handleProductsFilter = ->
    activeProducts = $(".product-filter.active").map (_, filter)->
      $(filter).data("product")
    .toArray()

    if activeProducts.length == 0
      $(".accreditation-box").show()
    else
      $(".accreditation-box").hide()
      activeProducts.forEach (i)->
        $(".accreditation-box[data-product-#{i}]").show()

  $(document).on "click",".btn-select-accreditation", ->

    $form = $("form")
    $btn = $(@)
    id = $btn.data("accreditation-id")
    $input = $form.find("input[value='#{id}']")
    if !!$input.length
      $input.remove()
      $btn.removeClass "active"
    else
      $form.append( hiddenInput("accreditations[]",id) )
      $btn.addClass "active"

  $(document).on "click", ".product-filter", ->
    $filter = $(@)
    $filter.toggleClass("active")
    handleProductsFilter()

  $(document).on "click", ".clean-products-filter", ->
    $(".product-filter").removeClass("active")
    handleProductsFilter()

  $(document).on "click", ".invert-products-filter", ->
    $(".product-filter").toggleClass("active")
    handleProductsFilter()

$(document).on("ready",ready)
