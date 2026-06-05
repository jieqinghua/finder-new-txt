ObjC.import("Foundation");

function decodeFileUrl(url) {
  return decodeURIComponent(String(url).replace(/^file:\/\//, ""));
}

function finderTargetFolder() {
  const finder = Application("Finder");

  if (finder.windows.length > 0) {
    const target = finder.windows[0].target();
    return decodeFileUrl(target.url());
  }

  return `${ObjC.unwrap($.NSHomeDirectory())}/Desktop/`;
}

function uniqueTextFilePath(folderPath) {
  const manager = $.NSFileManager.defaultManager;
  const baseName = "新建文本文件";
  const extension = ".txt";
  let candidate = `${folderPath}${baseName}${extension}`;
  let counter = 2;

  while (manager.fileExistsAtPath(candidate)) {
    candidate = `${folderPath}${baseName} ${counter}${extension}`;
    counter += 1;
  }

  return candidate;
}

function run() {
  const finder = Application("Finder");
  const manager = $.NSFileManager.defaultManager;
  const filePath = uniqueTextFilePath(finderTargetFolder());

  manager.createFileAtPathContentsAttributes(filePath, $.NSData.data, $());
  finder.reveal(Path(filePath));
}
