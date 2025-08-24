import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/location_repository_impl.dart';
import '../../data/repositories/map_repository_impl.dart';
import '../../data/services/location_service.dart';
import '../../domain/repositories/location_repository.dart';
import '../../domain/repositories/map_repository.dart';
import '../../domain/use_cases/location_use_case.dart';
import '../../domain/use_cases/map_use_case.dart';

part 'dependency_injection.g.dart';
part 'parts/services.dart';
part 'parts/repository.dart';
part 'parts/use_cases.dart';
