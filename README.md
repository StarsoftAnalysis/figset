# figset

**figset**, and its friend **figrow**, are [Hugo](https://gohugo.io/) [shortcodes](https://gohugo.io/content-management/shortcodes/) 
for adding images to webpages.

The difference from the standard **figure** shortcode is that **figset** uses HTML's <code>srcset</code>
attribute to provide optimised images for the user's screen.

Hugo's built-in image processing facilities are used to create the <code>srcset</code> images. 

**figrow** helps with organising images into galleries.

**figset** can use [lightboxSSA](https://github.com/StarsoftAnalysis/lightboxSSA) to create a light box or 
carousel-type gallery out of some or all of the images on a page.

## More details

Images are sized...   adjusted to have the same area

Uses flexbox...

## Examples

from page on figsetdev

## Sample Sites

PSA
AVS

## Using figset

The 

{{<figset name="pic1.png" caption="The first picture" alt="Descriptive text">}}

#### name

#### caption

## Summary of figset parameters

Note that text parameter values must be quoted if they contain spaces or other special characters.  For example, name=pic1.png, name="Picture One.png".
True/false values and numbers do not need to be quoted.  (true/false --- what will they do if quited?)

| Parameter      | Type |  Description |
| ----------- | ----------- |
| name      | text      |
| caption   | text        |

    .site       -- site
    .page       -- current page
    .figrow     -- true if we're within a figrow (which is independent of whether there's a gallery)
    .name       -- name of image within the page bundle or as a remote resource (starting with http[s]://)
    .image      -- (resource) -- image overrides name -- for use by other templates and partials
    .position   -- left/start, right/end, centre/center -- can be abbreviated.
    .size       -- thumb, small, medium, large, full  TODO other sizes  FIXME hook into bootstrap sizing
    .maxwidth   -- biggest size used for srcset in pixels, or for url=self
    .selfsize   -- max size in px of url=self image
    .title      -- shows as tool-tip
    .caption    -- forms the figcaption
    .alt        -- alt text for img, defaults to title or caption
    .url        -- url to link to -- on second click if galleried, or 'self'
    .gallery    -- name of gallery -- just has to be the same on a group of figures to make them a gallery - implies lightbox
    .lightbox   -- anything truthy to add lightbox effect without making it a gallery
    .sameheight -- true to make all images with the same .size value the same height 
    .class1     -- classes from parent figrow
    .class2     -- classes for this figset
    .capclass   -- classes for figcaption
    .id         -- id of this figset
    .debug      -- true to output debug info as warnings
    .sharpen    -- true to apply unsharp mask filter; does not affect fall-back non-srcset image







## Partials

To use figset and figrow from another template or partial, rather than via shortcodes from content,
you can use the figset and figrow partials.

The parameters are the same, but the way defaults are applied is different because there is no concept
of partials being nested as shortcodes can be.

Parameters get passed in as a dict, starting with the current site and page contexts.
e.g. {{ partial figset (dict  "site 
simple figset examplt

more complex example with figrow -- hae to do your own iterating, can't put defaults in the figrow
  DON'T FORGET!!
  * figset needs the site and page context to be passed in, 
  * when using figrow_start partial from another template:
    - put 'figrow true' in the figset partial's dict, otherwise the figcaptions get all narrow -- still don't know why exactly.

## Other notes

Remote images: don't forget that Hugo sites are static -- the image will be as retrieved when the site is built, and won't
change if the source changes until the site is rebuilt.

## To do

* Get rid of LightboxSSA -- it's not part of this module, it's a recommendation
* assets/images and static/images -- why are they not all in the same place?   where should they go in the user's structure?
* overwrite placeholder with name of missing image
* clear=both for figrow (don't pass it to figset)

* DONE? either use bootstrap consistently, or not at all -- i.e. remove the dependency.  bs is good for sizing etc.(?)
* lightboxSSA needs images in assets|static/images -- can that be fixed? 

### Stages

* get the layout and sizing right
  * what if figsets have position left/right within a row?
    - I think float is ignored within a flex-container -- we'll use the .figrow flag to not float within flex.
* lightbox
* links to big images or elsewhere, with or without gallery
* all the srcset stuff
* make captions fit
* DONE move CSS to a separate file to get merged into the rest -- to make for easier tuning of CSS aspects.
* how to module-ise the head stuff e.g. including lightboxssa where needed etc.
   - and maybe only use figset.scss where needed.

### Done

* decide about param names and values e.g. valign=left or align-contents=flex-start ?  -- custom ones
* shortcodes/partials/options -- what about namespacing?  parent?
* but might want some styling options.
-- see partials/figset.html for more history
* add site-wide options e.g. for unsharp 
