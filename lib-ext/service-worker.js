chrome.action.onClicked.addListener((tab) => {
  chrome.storage.sync.get(
    { lib_file: 'data.json', lib_pos: 1 },
    (items) => {
      let file = items.lib_file;
	let pos = items.lib_pos;
	console.log('pos', pos);
	let url = "file://" + file;
	fetch(url).then(r => r.json()).then(function (values) {
	    if (pos >= values.length) {
		pos = 0;
	    }
	    vals = values[pos];
	    pos++;
	    chrome.storage.sync.set({lib_pos: pos});
	    chrome.scripting.executeScript({
		target: {tabId: tab.id},
		func: fillTable,
		args: [vals],
	    });
	});
    }
  );
});

function fillTable(values) {
    const spec3 = '09.03.04.62';
    const spec4 = '09.04.04.68';
    const kaf = 'КАФЕДРА ПРОГРАММНОЙ ИНЖЕНЕРИИ';
    const ids = ["sys_code", "author", "supervisor", "critic", "title", "keywords", "annotation",
		 "year1", "pages_count", "publishing", "ui-spec", "ui-kafv", "ui-vo"];
    const opts = ["spec", "kafv", "vo"];
    for (let i = 0; i < 10/*ids.length*/; i++) {
	let l = document.getElementById(ids[i]);
	l.value = values[i];
    }
    els = document.getElementsByClassName("custom-combobox-input");
    for (let i = 0; i < 3; i++) {
	els[i].value = values[10 + i];
    }
    let l = document.getElementById("spec");
    for (let i = 0; i < l.options.length; i++) {
	if (l.options.item(i).value == ((values[10][4] == '3') ? spec3 : spec4)) {
            l.options.item(i).selected = true;
            break;
	}
    }
//    l.options.item((values[10][4] == '3') ? 37 : 38).selected = true;
    l = document.getElementById("kafv");
//    l.options.item(19).selected = true;
    for (let i = 0; i < l.options.length; i++) {
	if (l.options.item(i).value == kaf) {
            l.options.item(i).selected = true;
            break;
	}
    }
    l = document.getElementById("vo");
    l.options.item((values[10][4] == '3') ? 2 : 4).selected = true;
}
