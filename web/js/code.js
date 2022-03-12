function setPageSize(id) {
    var size = document.getElementById(id).value;
    var pageIndex = document.getElementById("page-index");
    var pageSize = document.getElementById("page-size");
    pageSize.value = size;
    pageIndex.value = "1";
    var form = document.getElementById("search-form");
    form.submit();
}

function setPageIndex(value) {
    var pageIndex = document.getElementById('page-index');
    pageIndex.value = value;
    submitForm("search-form");
}
function submitForm(id) {
    var form = document.getElementById(id);
    form.submit();
}

function setSearchKey(searchKey, searchBar) {
    var key = document.getElementById(searchKey);
    var search = document.getElementById(searchBar);
    key.value = search.value;
    submitForm("search-form");
}

function pagger(id, pageIndex, pageSize, totalPage, gap)
{
    var container = document.getElementById(id);
    var result = '';
    var limit;

    // First

    if (pageIndex != 1) {
        result += "<input type=\"button\" value=\"&Lt;\" />";
    } else {
        result += "<input type=\"button\" value=\"&Lt;\" onclick=\"setPageIndex('1')\" />";
    }
    // Previous
    if (pageIndex > 1) {
        result += "<input type=\"button\" value=\"&LT;\" onclick=\"setPageIndex('" + (pageIndex - 1) + "')\" />";
    } else {
        result += "<input type=\"button\" value=\"&LT;\"/>";
    }

    if (pageIndex <= totalPage - 2)
        limit = pageIndex - gap;
    else if (pageIndex == totalPage)
        limit = pageIndex - (gap * 2);
    else
        limit = pageIndex - (gap + 1);
    for (var i = limit; i < pageIndex; i++)
    {
        if (i >= 1)
        {
            result += "<input type=\"button\" value=\"" + i + "\" onclick=\"setPageIndex('" + i + "')\" />";
        }
    }

    result += "<input class = \"selected-page\" type=\"button\" value=\"" + pageIndex + "\" />";
    if (pageIndex > 2)
        limit = pageIndex + gap;
    else if (pageIndex == 1)
        limit = pageIndex + (gap * 2);
    else
        limit = pageIndex + gap + 1;
    for (var i = pageIndex + 1; i <= limit; i++)
    {
        if (i <= totalPage)
        {
            result += "<input type=\"button\" value=\"" + i + "\" onclick=\"setPageIndex('" + i + "')\" />";
        }
    }

// Next
    if (pageIndex < totalPage) {
        result += "<input type=\"button\" value=\"&GT;\" onclick=\"setPageIndex('" + (pageIndex + 1) + "')\" />";
    } else
    {
        result += "<input type=\"button\" value=\"&GT;\" />";
    }

    if (pageIndex != totalPage) {
        result += "<input type=\"button\" value=\"&Gt;\" />";
    } else {
        result += "<input type=\"button\" value=\"&Gt;\" onclick=\"setPageIndex('" + totalPage + "')\" />";
    }
    container.innerHTML = result;
}



