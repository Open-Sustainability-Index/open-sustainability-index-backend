export function fromSlug (str: string): string {
  return str.trim()
    .toLowerCase()
    .replace(/-/g, ' ') // dash to space/underscore/slash
}
