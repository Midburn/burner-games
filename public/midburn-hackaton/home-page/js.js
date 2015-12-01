function parse(val) {
    var result = "Not found",
        tmp = [];
    location.search
        //.replace ( "?", "" )
        // this is better, there might be a question mark inside
        .substr(1)
        .split("&")
        .forEach(function (item) {
            tmp = item.split("=");
            if (tmp[0] === val) result = decodeURIComponent(tmp[1]);
        });
    return result;
}
$(document).ready(function () {
    if (parse('id') != 'Not found') {
        swal({
            title: "הצלחה - תודה על הרשמתך", 
            text: "אנו נחזור אליך ב-48 השעות הקרובות בטלפון/במייל להמשך התהליך",
            showConfirmButton: true,
            confirmButtonText: "אישור",
            type: 'success'
        });


    }
});
