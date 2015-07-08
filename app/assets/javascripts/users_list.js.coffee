$(document).on "page:change", ->
  $('#users_list').dataTable
  	lengthMenu: [[10, 25, 50, 100], ["Display 10 items", "Display 25 items", "Display 50 items", "Display 100 items"]]
  	sPaginationType: "full_numbers"
  	order: [[ 0, "desc" ]]
  	oLanguage:{
	    oPaginate: {
	        sFirst:    "First"
	        sPrevious: "Previous"
	        sNext:     "Next"
	        sLast:     "Last"
	    }
	    sProcessing:   "sProcessing..."
	    sLengthMenu:   "_MENU_"
	    sZeroRecords:  "Zero Records"
	    sInfo:         "Display results from _START_ to _END_, total _TOTAL_ items"
	    sInfoEmpty:    "Display results from 0 to 0, total 0 item"
	    sInfoFiltered: "(Filtered from _MAX_ items)"
	    sInfoPostFix:  ""
	    sSearch:       ""
	    sSearchPlaceholder: "Search"
	    sUrl:          ""
	    sEmptyTable:     "Empty Table"
	    sLoadingRecords: "Loading Records..."
	    sInfoThousands:  ","
	    oAria: {
	        sSortAscending:  ": Sort Ascending"
	        sSortDescending: ": Sort Descending"
	    }
	}
