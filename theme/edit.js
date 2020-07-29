(function ($) {
    var table = null;
    var xButton = '<svg class="bi bi-x" width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M11.854 4.146a.5.5 0 0 1 0 .708l-7 7a.5.5 0 0 1-.708-.708l7-7a.5.5 0 0 1 .708 0z"/><path fill-rule="evenodd" d="M4.146 4.146a.5.5 0 0 0 0 .708l7 7a.5.5 0 0 0 .708-.708l-7-7a.5.5 0 0 0-.708 0z"/></svg>';

    $(document).on("click", '.comments',  function () {
        var id = $(this).attr("aria-id");
        var text = $(this).text();
        $(this).parent().children("input").show();
        $(this).parent().children("textarea").show();
        $(this).hide();
    });

    $(document).on("click", ".save", function() {
        //save

        //after save
        $(this).hide();
        $(this).parent().children("textarea").hide();
        var value = $(this).parent().children("textarea").val();
        $(this).parent().children("div").text(value);
        $(this).parent().children("div").show();

    });

    $(document).ready( function () {
         table = $('#data').DataTable( {
             "language": {
                "processing":     "Przetwarzanie...",
                "search":         "Szukaj:",
                "lengthMenu":     "Pokaż _MENU_ pozycji",
                "info":           "Pozycje od _START_ do _END_ z _TOTAL_ łącznie",
                "infoEmpty":      "Pozycji 0 z 0 dostępnych",
                "infoFiltered":   "(filtrowanie spośród _MAX_ dostępnych pozycji)",
                "infoPostFix":    "",
                "loadingRecords": "Wczytywanie...",
                "zeroRecords":    "Nie znaleziono pasujących pozycji",
                "emptyTable":     "Brak danych",
                "paginate": {
                    "first":      "Pierwsza",
                    "previous":   "Poprzednia",
                    "next":       "Następna",
                    "last":       "Ostatnia"
                },
                "aria": {
                    "sortAscending": ": aktywuj, by posortować kolumnę rosnąco",
                    "sortDescending": ": aktywuj, by posortować kolumnę malejąco"
                }
            }
        });

        $('[data-toggle="popover').popover();
        $('[data-toggle="tooltip"]').tooltip();
        $('.dropdown-toggle').dropdown();
    } );

})(jQuery);

jq('.dropdownBS').on('hidden.bs.dropdown', function () {
    jq(this).show();
});