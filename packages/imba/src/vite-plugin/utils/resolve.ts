import path from 'path';
import { builtinModules, createRequire } from 'module';
import { is_common_without_imba_field, resolveDependencyData } from './dependencies';
import { VitePluginImbaCache } from './vite-plugin-imba-cache';

export function resolveViaPackageJsonImba(
	importee: string,
	importer: string | undefined,
	cache: VitePluginImbaCache
): string | void {
	if (
		importer &&
		isBareImport(importee) &&
		!isNodeInternal(importee) &&
		!is_common_without_imba_field(importee)
	) {
		const cached = cache.getResolvedImbaField(importee, importer);
		if (cached) {
			return cached;
		}
		const localRequire = createRequire(importer);
		const pkgData = resolveDependencyData(importee, localRequire);
		if (pkgData) {
			const { pkg, dir } = pkgData;
			if (pkg.imba) {
				const result = path.resolve(dir, pkg.imba);
				cache.setResolvedImbaField(importee, importer, result);
				return result;
			}
		}
	}
}

function isNodeInternal(importee: string) {
	return importee.startsWith('node:') || builtinModules.includes(importee);
}

function isBareImport(importee: string): boolean {
	if (
		!importee ||
		importee[0] === '.' ||
		importee[0] === '\0' ||
		importee.includes(':') ||
		path.isAbsolute(importee)
	) {
		return false;
	}
	const parts = importee.split('/');
	switch (parts.length) {
		case 1:
			return true;
		case 2:
			return parts[0].startsWith('@');
		default:
			return false;
	}
}
