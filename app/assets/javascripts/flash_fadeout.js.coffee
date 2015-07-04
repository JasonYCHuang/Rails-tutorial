jQuery ->
	window.setTimeout (->
	  $('.alert-dismissible').fadeTo(500, 0).slideUp 500, ->
	    $(this).remove()
	    return
	  return
	), 5000