$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 50, 16, 10 mm, 55 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 50;                  // step 1 diameter
len1 = 10;                // step 1 length
d2 = 16;                  // step 2 diameter
len2 = 20;                // step 2 length
d3 = 10;                  // step 3 diameter
len3 = 25;                // step 3 length
total = 55;               // overall length
chamfer = 2.5;            // end chamfer
groove_r = 5;             // groove radius
groove_z = 32;            // groove position from the end
groove_w = 2.5;           // groove width
groove_d = 1.6;           // groove depth

/* closed turning profile: x is the radius, y is the length */
profile = [[0, 0], [25 - chamfer, 0], [25, chamfer], [25, 10], [8, 10], [8, 30], [5, 30], [5, 52.5], [2.5, 55], [0, 55]];

difference() {
  rotate_extrude() polygon(profile);
  /* circlip groove just behind the shoulder */
  rotate_extrude() translate([groove_r - groove_d, groove_z]) square([groove_d + 1, groove_w]);
}
