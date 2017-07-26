open Tyxml

let to_string = Format.asprintf "%a" (Html.pp_elt ())

let tyxml_tests l =
  let f (name, (ty : Html_types.body_content Html.elt), s) =
    name, `Quick, fun () -> Alcotest.(check string) name (to_string ty) s
  in
  List.map f l

let html_maps = "html maps", tyxml_tests Html.[

  "map in map",
  map [map []],
  "<map><map></map></map>" ;

  "area without href",
  map [area_nohref ()],
  "<map><area /></map>" ;

  "area with href",
  map [area ~alt:"a" ~href:(uri_of_string "b") ()],
  "<map><area alt=\"a\" href=\"b\" /></map>" ;

  "img usemap",
  img ~src:(uri_of_string "a") ~alt:"b" ~a:[a_usemap "c"] (),
  "<img src=\"a\" alt=\"b\" usemap=\"c\" />"

]

let tests = [
  html_maps ;
  escaping ;
]
