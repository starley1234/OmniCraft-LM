$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 40, 25, 16, 12 mm, 95 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 40;                  // step 1 diameter
len1 = 25;                // step 1 length
d2 = 25;                  // step 2 diameter
len2 = 10;                // step 2 length
d3 = 16;                  // step 3 diameter
len3 = 40;                // step 3 length
d4 = 12;                  // step 4 diameter
len4 = 20;                // step 4 length
total = 95;               // overall length
chamfer = 2;              // end chamfer
groove_r = 12.5;          // groove radius
groove_z = 27;            // groove position from the end
groove_w = 3.5;           // groove width
groove_d = 1.3;           // groove depth
cross_d = 6;              // cross pin hole
cross_z = 85;             // cross hole position

/* closed turning profile: x is the radius, y is the length */
profile = [[0, 0], [20 - chamfer, 0], [20, chamfer], [20, 25], [12.5, 25], [12.5, 35], [8, 35], [8, 75], [6, 75], [6, 93], [4, 95], [0, 95]];

difference() {
  rotate_extrude() polygon(profile);
  /* circlip groove just behind the shoulder */
  rotate_extrude() translate([groove_r - groove_d, groove_z]) square([groove_d + 1, groove_w]);
  /* cross pin hole through the small step */
  translate([0, 0, cross_z]) rotate([90, 0, 0]) cylinder(h = d4 + 4, d = cross_d, center = true);
}
