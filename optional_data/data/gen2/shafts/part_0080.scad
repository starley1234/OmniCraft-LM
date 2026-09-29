$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 50, 40, 20 mm, 60 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 50;                  // step 1 diameter
len1 = 10;                // step 1 length
d2 = 40;                  // step 2 diameter
len2 = 40;                // step 2 length
d3 = 20;                  // step 3 diameter
len3 = 10;                // step 3 length
total = 60;               // overall length
chamfer = 2.5;            // end chamfer
groove_r = 20;            // groove radius
groove_z = 12;            // groove position from the end
groove_w = 3.5;           // groove width
groove_d = 2;             // groove depth
cross_d = 6;              // cross pin hole
cross_z = 55;             // cross hole position

/* closed turning profile: x is the radius, y is the length */
profile = [[0, 0], [25 - chamfer, 0], [25, chamfer], [25, 10], [20, 10], [20, 50], [10, 50], [10, 57.5], [7.5, 60], [0, 60]];

difference() {
  rotate_extrude() polygon(profile);
  /* circlip groove just behind the shoulder */
  rotate_extrude() translate([groove_r - groove_d, groove_z]) square([groove_d + 1, groove_w]);
  /* cross pin hole through the small step */
  translate([0, 0, cross_z]) rotate([90, 0, 0]) cylinder(h = d3 + 4, d = cross_d, center = true);
}
