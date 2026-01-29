class_name TestUtils

#region Assert

static func subset_of(small: Array, big: Array) -> bool:
    for element in small:
        if not big.has(element):
            return false
    
    return true

#endregion

#region Tools

## Return recursively all file within a folder
static func get_files_recursive(folder_path: String, extension: String = "") -> Array[String]:
    var results: Array[String] = []
    var dir := DirAccess.open(folder_path)
    
    if dir == null:
        push_error("Impossible d'ouvrir le dossier : " + folder_path)
        return results
    
    dir.list_dir_begin()
    var file_name := dir.get_next()
    
    while file_name != "":
        if file_name != "." and file_name != "..":
            var full_path := folder_path.path_join(file_name)
            
            if dir.current_is_dir():
                # Appel récursif
                results.append_array(
                    get_files_recursive(full_path, extension)
                )
            else:
                if extension == "" or file_name.get_extension() == extension:
                    results.append(full_path)
        
        file_name = dir.get_next()
    
    dir.list_dir_end()
    return results

#endregion
