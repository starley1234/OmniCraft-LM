$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 50, 25, 20, 12, 10 mm, 130 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 50;                  // step 1 diameter
len1 = 20;                // step 1 length
d2 = 25;                  // step 2 diameter
len2 = 30;                // step 2 length
d3 = 20;                  // step 3 diameter
len3 = 30;                // step 3 length
d4 = 12;                  // step 4 diameter
len4 = 25;                // step 4 length
d5 = 10;                  // step 5 diameter
len5 = 25;                // step 5 length
total = 130;              // overall length
chamfer = 1;              // end chamfer
groove_r = 12.5;          // groove radius
groove_z = 22;            // groove position from the end
groove_w = 2.5;           // groove width
groove_d = 2;             // groove depth

/* closed turning profile: x is the radius, y is the length */
profile = [[0, 0], [25 - chamfer, 0], [25, chamfer], [25, 20], [12.5, 20], [12.5, 50], [10, 50], [10, 80], [6, 80], [6, 105], [5, 105], [5, 129], [4, 130], [0, 130]];

difference() {
  rotate_extrude() polygon(profile);
  /* circlip groove just behind the shoulder */
  rotate_extrude() translate([groove_r - groove_d, groove_z]) square([groove_d + 1, groove_w]);
}
