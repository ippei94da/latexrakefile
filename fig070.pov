camera { orthographic
  location < 33.0,-8.0,10.0 >
  look_at  <  5.0, 5.0, 5.0 >
  sky      <  0.0, 0.0, 1.0 >
  right    <-1.33, 0.0, 0.0 >
  up       <  0.0, 1.0, 0.0 >
  angle    34
}
background {color rgb<1,1,1>}
light_source{ < 4, 1, 4 > color <1,1,1> parallel point_at 0 }
#default{ texture{ finish{ ambient 0.4 phong 1.0 phong_size 10 } } }

#local cube_color = color rgb <0.9, 0.9, 0.9>;
#local v1_color   = color rgb <1.0, 0.0, 0.0>;
#local v2_color   = color rgb <0.0, 1.0, 0.0>;

#local v000       = < 0, 0, 0>;
#local v001       = < 0, 0,10>;
#local v010       = < 0,10, 0>;
#local v011       = < 0,10,10>;
#local v100       = <10, 0, 0>;
#local v101       = <10, 0,10>;
#local v110       = <10,10, 0>;
#local v111       = <10,10,10>;

// edges
object{cylinder{v000, v100, 0.1} pigment{cube_color}}
object{cylinder{v100, v110, 0.1} pigment{cube_color}}
object{cylinder{v110, v010, 0.1} pigment{cube_color}}
object{cylinder{v010, v000, 0.1} pigment{cube_color}}
object{cylinder{v000, v001, 0.1} pigment{cube_color}}
object{cylinder{v010, v011, 0.1} pigment{cube_color}}
object{cylinder{v110, v111, 0.1} pigment{cube_color}}
object{cylinder{v100, v101, 0.1} pigment{cube_color}}
object{cylinder{v001, v101, 0.1} pigment{cube_color}}
object{cylinder{v101, v111, 0.1} pigment{cube_color}}
object{cylinder{v111, v011, 0.1} pigment{cube_color}}
object{cylinder{v011, v001, 0.1} pigment{cube_color}}

// vertices
object { sphere{v000, 0.5} pigment {v1_color} }
object { sphere{v100, 0.5} pigment {v2_color} }
object { sphere{v110, 0.5} pigment {v1_color} }
object { sphere{v010, 0.5} pigment {v2_color} }
object { sphere{v001, 0.5} pigment {v2_color} }
object { sphere{v101, 0.5} pigment {v1_color} }
object { sphere{v111, 0.5} pigment {v2_color} }
object { sphere{v011, 0.5} pigment {v1_color} }

//// diagonals
object{cylinder{v000, v011, 0.1} pigment{v1_color}}
object{cylinder{v000, v101, 0.1} pigment{v1_color}}
object{cylinder{v000, v110, 0.1} pigment{v1_color}}
//object{cylinder{v011, v101, 0.1} pigment{v1_color}}
//object{cylinder{v101, v110, 0.1} pigment{v1_color}}
//object{cylinder{v110, v011, 0.1} pigment{v1_color}}
//
object{cylinder{v111, v100, 0.1} pigment{v2_color}}
object{cylinder{v111, v010, 0.1} pigment{v2_color}}
object{cylinder{v111, v001, 0.1} pigment{v2_color}}
//object{cylinder{v100, v010, 0.1} pigment{v2_color}}
//object{cylinder{v010, v001, 0.1} pigment{v2_color}}
//object{cylinder{v001, v100, 0.1} pigment{v2_color}}
//
//
