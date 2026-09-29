$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 50, 20, 14, 10 mm, 125 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 50;                  // step 1 diameter
len1 = 30;                // step 1 length
d2 = 20;                  // step 2 diameter
len2 = 30;                // step 2 length
d3 = 14;                  // step 3 diameter
len3 = 40;                // step 3 length
d4 = 10;                  // step 4 diameter
len4 = 25;                // step 4 length
total = 125;              // overall length
chamfer = 1.5;            // end chamfer
groove_r = 5;             // groove radius
groove_z = 102;           // groove position from the end
groove_w = 3.5;           // groove width
groove_d = 1.3;           // groove depth
cross_d = 4;              // cross pin hole
cross_z = 15;             // cross hole position

/* closed turning profile: x is the radius, y is the length */
profile = [[0, 0], [25 - chamfer, 0], [25, chamfer], [25, 30], [10, 30], [10, 60], [7, 60], [7, 100], [5, 100], [5, 123.5], [3.5, 125], [0, 125]];

difference() {
  rotate_extrude() polygon(profile);
  /* circlip groove just behind the shoulder */
  rotate_extrude() translate([groove_r - groove_d, groove_z]) square([groove_d + 1, groove_w]);
  /* cross pin hole through the small step */
  translate([0, 0, cross_z]) rotate([90, 0, 0]) cylinder(h = d1 + 4, d = cross_d, center = true);
}
